; 日付を入力 (aaa または Ctrl+テンキーの.)
#Requires AutoHotkey v2.0

; 半角で "aaa" と打つ → 今日の日付 (YYYY-MM-DD)
:*:aaa::
{
	SendInput FormatTime(, "yyyy-MM-dd")
}

; Ctrl + テンキーの . → 今日の日付 (YYYY-MM-DD)
^NumpadDot::
{
	SendInput FormatTime(, "yyyy-MM-dd")
}
