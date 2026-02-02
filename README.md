# AHK_Script

Windows 用の AutoHotkey (AHK) スクリプト集です。Cursor や Obsidian を使うときのショートカット・日付入力・ウィンドウ入れ替えなどに使います。

## 必要なもの

- [AutoHotkey v1.1](https://www.autohotkey.com/) をインストールしておく

## スクリプト一覧

### insert_date.ahk

- **やること** … 今日の日付（YYYY-MM-DD）を一発で入力する
- **使い方**
  - 半角英数で `aaa` と入力し、直後に **スペース** または **Enter** を押すと、その場が今日の日付に置き換わる
  - Chrome・Obsidian・メモ帳など、どこでも使える
- **起動** … ファイルをダブルクリック。常時使うなら「スタートアップ」フォルダにショートカットを置く

### swap_screens.ahk

- **やること** … Cursor と Chrome（一番大きいウィンドウ）の位置・サイズを入れ替える
- **使い方**
  - **Ctrl + Alt + S** を押すと、Cursor と Chrome が左右（またはモニター間）で入れ替わる
  - 最大化していたウィンドウは、入れ替え後もそのモニターで最大化される
- **起動** … ファイルをダブルクリック。起動時に「Swap screens loaded. Ctrl+Alt+S to swap Cursor and Chrome.」と表示される

## フォルダ構成

```
AHKScript/
  insert_date.ahk   … 日付入力
  swap_screens.ahk … Cursor と Chrome の入れ替え
```

## ライセンス

とくに定めていません。個人利用・改変は自由です。
