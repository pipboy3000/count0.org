---
layout: post
title: nagoya.vimに行ってきました
categories: vim event
---
[nagoya.vim #1](http://connpass.com/event/3179/) 9/7 12:15 start at [station](http://station-share.com/)に行ってきました。そのメモです。結論からいうとhelp読め。英語苦手なら日本語help読めです。

## 12:15 ~ 13:00 イントロダクション、Vim の便利な機能紹介 @c0hama
基本操作について。

## 13:10 ~ 13:40 Vim script と正しい vimrc の書き方 @c0hama

[スライドはこちら](http://www.slideshare.net/cohama/vim-script-vimrc-nagoyavim-1)

* 歴史的な理由により言語仕様が。
* コマンドによって引数の解釈が違うので、`:help {keyword}`で調べる。もしくは`:h {keyword}`。結構適当なキーワードでも検索できる。
* 変数宣言だけでなく、使う時も`let`が必要。
* 変数スコープがたくさんある。グローバル、ローカル、スクリプトローカル、関数の引数、バッファローカル、ウィンドウローカル。`:help internal-variables`
* プラグインの設定はグローバル変数。確かによく使う。例えば`let g:syntastic_enable_signs = 1`。
* 式が必要とされている場所では、式が使える。
* commandで複数行にわたる処理をしたい場合は、command名と同じ関数を定義して呼び出す。`:help user-commands`
* autocmdはイベントドリブンな処理を実行。`:help autocmd-events`
* vimrcの設定は個人差が激しいのでネットに転がるオススメを鵜呑みせず、helpをみましょう。自分で試しましょう。
* `<expr>`をつけると式の評価結果にマッピングできる`:help map-expression`
* リローダブルなvimrc  
  vimrcを一瞬で設定反映できるようにしましょう。  
  [Vimの極め方](http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation)
* グローバルとローカル `:help setlocal`  
  `:set`よりは`:setlocal` 
* マッピングを使い分ける `:help map-commands`  
  既存の設定を潰さない  
  bad `nnoremap <C-a> ggVG`  
  good `nnoremap g<C-a> ggVG`
* `<C-a>`は便利なので潰さない`:help CTRL-A`  
  これは自分でもやってた。行頭へジャンプするようにしていました。
  ```
  imap <C-a> <C-o>0
  ```  
  実践vim`<C-a>`でも便利だと書いてありました。

## 13:40 ~ 14:20 Vim plugin について説明および紹介 @sgur

* プラグインの種類  
  汎用  
  ファイルタイプ  
  カラースキーム  
  その他
* プラグインロードの仕組み  
  runtimepath重要 `:help runtimepath`  
* スクリプトの読み込み順序を一覧できる `:scriptnames`
* autoload `:help autoload`  
  関数が呼び出されたタイミングでスクリプトをロードする  
  起動時間を短縮できる
* プラグインのインストール  
  pathogen, Vundle, NeoBundle  
  自分の場合は[Vundle](https://github.com/gmarik/vundle)を使っています

あとは怒涛のプラグイン紹介でした。

[プラグイン紹介の資料](https://gist.github.com/sgur/6434642)

重要なのはヘルプ日本語版 [vimdoc-ja](https://github.com/vim-jp/vimdoc-ja)  
kaoriya版には標準でインストールされています。  
自分はhomebrewでvimをインストールしているため、vundleで別途インストールしました。

## 個人的に手放せないプラグイン
* [Emmet(ZenCoding)](https://github.com/mattn/emmet-vim)  
  html書くときはこれが便利です。
* [vim-surround](https://github.com/tpope/vim-surround)  
  html編集するときはこれが便利です。 
* [unite.vim](https://github.com/Shougo/unite.vim), [ctrlp.vim](https://github.com/kien/ctrlp.vim)  
  機能が似ているが併用しています。
* [Syntastic](https://github.com/scrooloose/syntastic)  
  書いて保存したらシンタックスチェック、lintが走ります。

## 14:20 ~ 14:50 みんなで vimrc を書いてみる
自習、語らいの時間でした。

## 実践Vim
挙手のアンケートで所持率の高かった実践Vimですが、オススメです。目からウロコの内容が満載です。読み進めるのが非常に楽しい一冊です。だんだん新興宗教じみてきましたので、このへんで。電子書籍版は[達人出版会から購入](http://tatsu-zine.com/books/practical-vim)できます。


