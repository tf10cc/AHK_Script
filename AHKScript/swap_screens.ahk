; ===== Cursor と Chrome の位置・サイズを入れ替え (Ctrl+Alt+S)
; 使用: Ctrl+Alt+S で Cursor と「一番大きい Chrome ウィンドウ」を入れ替え
; 最大化中は一度通常サイズに戻してから移動

#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; 起動時メッセージ（半角英字）
ToolTip, Swap screens loaded. Ctrl+Alt+S to swap Cursor and Chrome.
SetTimer, RemoveStartupTip, 2500
return

^!s::
	; Cursor ウィンドウを探す (ahk_exe で Cursor のプロセス)
	cursorID := ""
	WinGet, list, List
	Loop, %list%
	{
		id := list%A_Index%
		WinGet, proc, ProcessName, ahk_id %id%
		WinGetTitle, title, ahk_id %id%
		if (proc = "Cursor.exe" && title != "")
		{
			cursorID := id
			break
		}
	}
	if (!cursorID)
	{
		ToolTip, Cursor が見つかりません
		SetTimer, RemoveToolTip, 2000
		return
	}

	; 一番大きい Chrome ウィンドウを探す
	chromeID := ""
	maxArea := 0
	Loop, %list%
	{
		id := list%A_Index%
		WinGet, proc, ProcessName, ahk_id %id%
		WinGetTitle, title, ahk_id %id%
		if (proc = "chrome.exe" && title != "")
		{
			WinGet, style, Style, ahk_id %id%
			; 0x10000000 = WS_VISIBLE
			if (style & 0x10000000)
			{
				WinGetPos, x, y, w, h, ahk_id %id%
				area := w * h
				if (area > maxArea)
				{
					maxArea := area
					chromeID := id
				}
			}
		}
	}
	if (!chromeID)
	{
		ToolTip, Chrome が見つかりません
		SetTimer, RemoveToolTip, 2000
		return
	}

	; 最大化なら解除
	WinGet, cursorMax, MinMax, ahk_id %cursorID%
	WinGet, chromeMax, MinMax, ahk_id %chromeID%
	if (cursorMax = 1)
		WinRestore, ahk_id %cursorID%
	if (chromeMax = 1)
		WinRestore, ahk_id %chromeID%
	Sleep, 50

	; 位置・サイズ取得
	WinGetPos, cx, cy, cw, ch, ahk_id %cursorID%
	WinGetPos, gx, gy, gw, gh, ahk_id %chromeID%

	; 入れ替え
	WinMove, ahk_id %cursorID%, , %gx%, %gy%, %gw%, %gh%
	WinMove, ahk_id %chromeID%, , %cx%, %cy%, %cw%, %ch%

	; 元が最大化だったら入れ替え後も最大化
	if (cursorMax = 1)
		WinMaximize, ahk_id %cursorID%
	if (chromeMax = 1)
		WinMaximize, ahk_id %chromeID%

	ToolTip, 入れ替えました
	SetTimer, RemoveToolTip, 2000
	return

RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
	return

RemoveStartupTip:
	SetTimer, RemoveStartupTip, Off
	ToolTip
	return
