---
layout: post
title: ワークショップの題材をRubyMotionでも作ってみた
categories: ios ruby
---
2012年12月23日に開催された[第11回iPhoneアプリ開発勉強会](http://atnd.org/events/34953)で「1時間で作るシンプルアプリ」（講師：[鈴木秀明さん](http://blog.lapture.net/)）というワークショップがありました。このワークショップの題材をObjective-Cで進める傍らでRubyMotionでもコードを書いたので、それのメモ。

### ソースコード
* [Obj-C版](https://github.com/pipboy3000/Obj-C-Practice-Sample)
* [RubyMotion版](https://github.com/pipboy3000/Motion-Practice-Sample)

### arc4randomがないよ
arc4randomでランダムな値をゲットする箇所がObj-C版にはあったけど、arc4random関数をRubyMotionで呼び出してもエラーになる。RubyのRandomに書き直した。わかったか、俺。

### M_PIがないよ
同じくM_PIなんて定数はRubyにはない。Math::PIです。無知を呪え、俺。

### tap便利
UI部品の設定を書くとき、Rubyのtapはすごく便利。普段の書き捨てSinatraアプリのコードでは使ったことないけど、これからは積極的に使っていこうと決意した。

### Xcode便利
typoしたら速攻指摘してくれるXcodeはものすごく便利。RubyMotion版はVimで書いていたけど、コード補完できてないから、とても長いメソッド名をいちいち打ち込んでいた。2回目は補完できるけど、XcodeとVimを行き来してると両者の差が圧倒的です。

### 配列、文字列が楽ちん
もちろんRubyMotionの方。Objective-CでもModern Objective-C Syntaxで簡単に書けるらしいけど、それよりも楽ちんです。

---

結構短いコードだけど、同時進行でRubyMotionに翻訳しつつ実行、エラー、書き直しというのはなかなかエキサイティングでした。
