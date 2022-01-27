---
layout: post
title: changelog, humnas.txt, figlet, モバイル対応
categories: misc
---
ブログの細々とした修正についてまとめました。今回はhumans.txt、figlet、モバイル対応について。

## humans.txt
[humans.txt](http://humanstxt.org/JA)を導入しました。<http://count0.org/humans.txt>が本サイトのhumans.txtです。これはウェブサイトを作った人、運用している人の情報を書いてサーバに設置しておくテキストファイルです。

自分の場合、お仕事のウェブサイト制作に誰がどんな役割で関わったのかという情報がほぼ残りません。例えば季節ものの仕事で去年だれがやったっけ？ という事がよくあります。ちゃんと管理しとけよという話だけど、humans.txtへ仕事に関わった人を書いておくと後々役に立つかもしれません。

## figlet
humans.txtとhtmlのソースコードにfigletで作ったテキスト・バナーを貼りました。figletはテキスト・バナーをつくるプログラムです。OSXならhomebrewでインストールできます。

```
  brew install figlet // install
  figlet hogehoge
  _                      _
 | |__   ___   __ _  ___| |__   ___   __ _  ___
 | '_ \ / _ \ / _` |/ _ \ '_ \ / _ \ / _` |/ _ \
 | | | | (_) | (_| |  __/ | | | (_) | (_| |  __/
 |_| |_|\___/ \__, |\___|_| |_|\___/ \__, |\___|
              |___/                  |___/
```

素晴らしいテキスト・バナーが出来上がりました。  
プログラムをインストールしなくても[figlet generator](http://www.google.com/search?q=figlet%20generator)でググるとブラウザでfigletできるサイトがいくつもありますが、日本語フォントだと、バックスラッシュが¥マークになるので要注意です。

homebrewでインストールした場合、フォントファイルは`/usr/local/share/figlet/fonts/`以下に入っています。

``` 
  figlet -f /usr/local/share/figlet/fonts/smslant.flf hogehoge
    __                 __
   / /  ___  ___ ____ / /  ___  ___ ____
  / _ \/ _ \/ _ `/ -_) _ \/ _ \/ _ `/ -_)
 /_//_/\___/\_, /\__/_//_/\___/\_, /\__/
           /___/              /___/

  figlet -f /usr/local/share/figlet/fonts/shadow.flf hogehoge
   |                      |
   __ \   _ \   _` |  _ \ __ \   _ \   _` |  _ \
   | | | (   | (   |  __/ | | | (   | (   |  __/
  _| |_|\___/ \__, |\___|_| |_|\___/ \__, |\___|
              |___/                  |___/
```

## モバイル対応
css3 media queryを使ってモバイル対応しました。ブラウザのウィンドウを狭めていくと、モバイル版count0.orgが見れます。
