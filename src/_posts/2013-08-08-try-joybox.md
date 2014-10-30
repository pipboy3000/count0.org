---
layout: post
title: 本当に15分でJoyboxを使ってアステロイドゲームを作れるか挑戦
categories: ruby
image: /images/try-joybox1.png
---
30分かかりました。Joyboxはrubymotionでcocos2d, box2dを動かすラッパーです。cocos2dは2dゲームを作るフレームワークで、box2dは物理エンジン。ネタ元の記事は[Create an Asteroids Game for iOS in 15 Minutes… with Joybox 1.1.0 and RubyMotion! - RubyMotion Blog](http://blog.rubymotion.com/post/57465814533/create-an-asteroids-game-for-ios-in-15-minutes-with)。どんなものが出来上がるかはリンク先の下にある動画から確認できます。

開発環境はvimです。tmuxで画面を分割して片一方でコンパイルさせました。ctagsを使ってません。リンク先のコード以外は読まずにカリカリとコードを書きました。時間がかかったのはtypoしまくったからです・・・。あと、初回のコンパイルは長かった。

[![開発の様子](/images/try-joybox2.png)](/images/try-joybox2.png)

コードを読んで書きながらきっとこういう動きになるんだなー。と容易に想像ところがJoyboxイイねであり、ruby(motion)イイねと思いました。

``` bash
  motion create --template=joybox-ios asteroid
```

プロジェクトのひな形が用意されていてapp_delegate.rbにコード生成されているのが楽だなと思いました。楽といえば、素材画像がダウンロードできてよかった。コードは書けても、隕石やロケットの絵は難しいですから。

## リンク
* [Joybox](http://joybox.io/)
* [Cocos2d](http://www.cocos2d-iphone.org/)
