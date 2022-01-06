---
layout: post
title: UITabbarControllerで一部のViewを回転させたい 
categories: ios
---
UITabbarControllerの管理下にあるViewの回転は、すべて回転に反応するか、しないかである。

しかし、一部のViewは回転して、他は回転に反応させたくないときはどうすればいいか。これがなかなか難しい。

結論というか自分が採用した方法は、回転させたいViewをmodalViewにする。Stack Overflowを読みまくった結果である。ちなみにUITabbarControllerが回転しないよという質問が多すぎるぜ。

動作の例を出すと、iPhoneに標準でインストールされている写真.appとYouTube.app。

写真.appはすべての場面で回転に反応するUITabbarControllerベースのアプリ。一方YouTube.appは写真.appと同じく UITabbarControllerベースのアプリだが、動画再生時のみに画面の回転に反応する。そして、動画再生時はmodalViewになってい る。

そんなわけで手っ取り早く済ませたい場合はmodalVIewがいいよ。
