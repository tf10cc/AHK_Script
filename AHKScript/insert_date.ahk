; Windows全体で「テキストを打つと日付に置き換わる」＋「テンキーで日付」
; 使い方: このファイルをダブルクリックで起動。常時使うなら「shell:startup」にショートカットを置く

; ===== ホットストリング: 半角で "aaa" と打ってスペース or Enter → 今日の日付に置換（Chrome・Obsidian・どこでも）
; ※ 半角英数で "aaa" と入力し、直後にスペースかEnterを押すと発動
:*:aaa::
  FormatTime, TimeString, A_Now, yyyy-MM-dd
  SendInput, %TimeString%
Return

; Ctrl + テンキーの . を押す → 今日の日付 YYYY-MM-DD を入力（どこでも有効）
^NumpadDot::
  FormatTime, TimeString, A_Now, yyyy-MM-dd
  Send, %TimeString%
Return

; テンキー1キーだけで出したい場合は下のブロックを使い、上の ^NumpadDot を ; で止める
; NumpadDot::   → テンキーの . だけ（ただし普段の小数点入力が使えなくなる）
; Numpad0::     → テンキーの 0 だけ
