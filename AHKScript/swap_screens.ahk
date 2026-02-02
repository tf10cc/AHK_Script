; Cursor と Chrome を入れ替え (Ctrl+Alt+S)
#Requires AutoHotkey v2.0

ToolTip "Swap loaded"
SetTimer () => ToolTip(), -1500

^!s:: {
	; Cursor を探す
	cursorID := 0
	for id in WinGetList() {
		try {
			if (WinGetProcessName("ahk_id " id) = "Cursor.exe" && WinGetTitle("ahk_id " id) != "") {
				cursorID := id
				break
			}
		}
	}
	
	; Chrome を探す
	chromeID := 0
	maxArea := 0
	for id in WinGetList() {
		try {
			if (WinGetProcessName("ahk_id " id) = "chrome.exe" && WinGetTitle("ahk_id " id) != "") {
				WinGetPos(&x, &y, &w, &h, "ahk_id " id)
				if (w * h > maxArea) {
					maxArea := w * h
					chromeID := id
				}
			}
		}
	}
	
	if (!cursorID || !chromeID)
		return
	
	; どのモニターにいるか取得（最大化していても分かる）
	cursorMon := DllCall("User32\MonitorFromWindow", "Ptr", cursorID, "UInt", 2, "Ptr")
	chromeMon := DllCall("User32\MonitorFromWindow", "Ptr", chromeID, "UInt", 2, "Ptr")
	
	; 各モニターの作業領域を取得
	mi1 := Buffer(40, 0)
	NumPut("UInt", 40, mi1, 0)
	DllCall("User32\GetMonitorInfo", "Ptr", cursorMon, "Ptr", mi1)
	c_left := NumGet(mi1, 20, "Int")
	c_top := NumGet(mi1, 24, "Int")
	c_right := NumGet(mi1, 28, "Int")
	c_bottom := NumGet(mi1, 32, "Int")
	
	mi2 := Buffer(40, 0)
	NumPut("UInt", 40, mi2, 0)
	DllCall("User32\GetMonitorInfo", "Ptr", chromeMon, "Ptr", mi2)
	g_left := NumGet(mi2, 20, "Int")
	g_top := NumGet(mi2, 24, "Int")
	g_right := NumGet(mi2, 28, "Int")
	g_bottom := NumGet(mi2, 32, "Int")
	
	; 最大化を記録
	cMax := WinGetMinMax("ahk_id " cursorID)
	gMax := WinGetMinMax("ahk_id " chromeID)
	
	; 復元
	WinRestore "ahk_id " cursorID
	WinRestore "ahk_id " chromeID
	Sleep 50
	
	; モニター単位で移動
	WinMove g_left, g_top, g_right - g_left, g_bottom - g_top, "ahk_id " cursorID
	WinMove c_left, c_top, c_right - c_left, c_bottom - c_top, "ahk_id " chromeID
	Sleep 50
	
	; 最大化を戻す
	if (cMax = 1)
		WinMaximize "ahk_id " cursorID
	if (gMax = 1)
		WinMaximize "ahk_id " chromeID
	
	ToolTip "Swapped"
	SetTimer () => ToolTip(), -1000
}
