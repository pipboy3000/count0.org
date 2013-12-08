---
layout: post
title: tmuxinatorでpaneのレイアウトを指定する
categories: linux
---
tmuxを起動して手が勝手に`z |` `z s` `z(押しつつ) kk` `z(押しつつ) ll`と打ち、それぞれのpaneで`vim`, `foreman start`, なにもしないでbashということをやっています。これは何かというと画像を見るのがてっとり早いです。

![tmuxで画面分割](/images/tmuxinator-layout.png)

最初の`z |`は画面を垂直分割。右のpaneがアクティブなので`z s`で水平分割。右下のpaneがアクティブになるので、`z(押しつつ) kk`で右下のpaneの高さを広げ、`z(押しつつ) ll`で左のpaneの横幅を広げるという芸当を無意識に幾度となく実行してきました。その結果が上の画像です。ようやく疑問を抱きました。なにやってんだ、俺。

ググッた結果、[teamocil](https://github.com/remiprev/teamocil)というのものあるのですが、[tmuxinator](https://github.com/aziz/tmuxinator)を使ってみました。tmuxinatorは設定ファイルに定義されたtmuxのpaneやwindowを再現してくれるものです。

``` bash
  gem install tmuxinator # gemでインストール
  rbenv rehash # rbenv環境なのでコマンドがインストールされたらrehash
  tmuxinator doctor # $EDITORと$SHELLが設定されているか確認してくれる
  tmuxinator new blog # ひな形作成
  vim ~/.tmuxinator/blog.yml # 設定ファイルを編集
```

ここで困ったのがpaneのレイアウトです。githubのページには[the five standard layouts](http://manpages.ubuntu.com/manpages/precise/en/man1/tmux.1.html#contenttoc6)を使うか[自分で定義する](http://stackoverflow.com/questions/9812000/specify-pane-percentage-in-tmuxinator-project/9976282#9976282)と書いてあります。自分で定義したものを使いたかったのですが、リンク先のstackoverflowのページに書かれているレイアウトの指定がよくわからない。なんとなくわかるようで全くわからない。

どうすればいいかというと、記事の冒頭で行ったようにtmuxで自分のやりたいpaneのレイアウトを作り、`tmux list-windows`すると設定ファイルに記述するレイアウトの値が表示されるというものです。ちゃんと英語で書いてありました。その結果、blog.ymlは以下のようになりました。

``` yaml
# ~/.tmuxinator/blog.yml

name: blog
root: ~/Desktop/blog/

windows:
  - main:
      layout: 0e75,178x50,0,0{101x50,0,0,0,76x50,102,0[76x13,102,0,1,76x36,102,14,2]}
      panes:
        - vim
        - foreman start
        - #empty
```

`tmuxinator`は`mux`というaliasが用意されているので、ブログを書きたくなったら

``` bash
mux start blog
```

とコマンドを打つだけで、記事の冒頭に書いたようなコマンドをいちいち打たなくても済むようになりました。めでたい。

## リンク
* [tmuxinator](https://github.com/aziz/tmuxinator)
* [tmuxのmanページ the five standard layouts](http://manpages.ubuntu.com/manpages/precise/en/man1/tmux.1.html#contenttoc6)
* [stackoverflow 独自のレイアウトを設定したい場合への回答](http://stackoverflow.com/questions/9812000/specify-pane-percentage-in-tmuxinator-project/9976282#9976282)
* [teamocil](https://github.com/remiprev/teamocil)

