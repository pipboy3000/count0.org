---
layout: post
title: Steamコントローラを買ったのでWin, Mac Raspberry Piで試す
categories: game raspberrypi
---

2008年から愛用しているXBOXコントローラの調子が悪く、幾つかのボタンの効きがすこぶる悪い。グレネードを投げたり近接攻撃を繰り出したつもりが何もしていなくて、敵に殴られることが多くなった。DOOMで酷使しすぎたのが原因かもしれない。従来通りXBOXコントローラが丈夫かつ安いので、それでも良かったけど、趣向を変えてSteamコントローラーに挑戦してみることに。

日本からでもAmazonで購入できるが、Amazon.comで購入。本体と送料で$49.99 + $6.16。7月20日発送、29日着。最初の予定では8月9日着だったので早いといえば早い。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">steam controller届いた！ <a href="https://t.co/nV8R4Ln1Zv">pic.twitter.com/nV8R4Ln1Zv</a></p>&mdash; アサイマサミ (@count0) <a href="https://twitter.com/count0/status/758973846900707328">2016年7月29日</a></blockquote> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Steamコントローラの特徴は動画を見たり[製品ページ][steamcontroller]を見ると手っ取り早いです。

<div class="videoplayer">
<iframe width="560" height="315" src="https://www.youtube.com/embed/8fs2Yh1PFwM" frameborder="0" allowfullscreen></iframe>
</div>

## Windowsで使ってみる

PCにレシーバーを取り付ければすぐ使える。デスクトップモードでマウス代わりに使えてちょっとした操作もコントローラで済むのは便利。日本語入力はできないけど、ソフトウェアキーボードで入力もできる。デュアルトラックパッドのハプティクスフィードバックが振動とジジジという音で伝わってきて気持ち良い。

タッチパッドは最初は照準を合わせるのに苦労しても次第に具合がつかめてきて、慣れ次第。右のタッチパッドに指を置いたままコントローラを傾けるとモーションコントロールができて、2種類の操作方法を随時切り替えながら遊べる。背面のボタンは単純に便利。

キーボード + マウスのゲームはメーカーもしくはコミュニティからキーアサインが提供されているので、慣れてしまえばどんなゲームもコントローラで操作できるのは気に入っている。

あと地味にワイヤレス便利。XBOXコントローラのケーブルがとても長くて足に引っ掛けていたりしたもので。

## Macで使ってみる

レシーバーを取り付けSteamクライアントが起動している間に限って使えた。デスクトップモードも使える。ソフトウェアキーボードの挙動がおかしくて、全画面でソフトウェアキーボードが立ち上がってしまうのと動きがもっさりで、そうじゃないんだよね感がすごい。これは今後の改善に期待。

新しいMacbookではローグライクを遊ぶ程度でコントローラの必要性は低いかと思いきや、SteamストリーミングでPCからMacにゲームをストリーミングして遊べるということに今更気づく。しかもすごく簡単にストリーミングできる。

[以前Raspberry PiでMoonlight Embedded動かしていた時より]({% post_url 2014-10-30-air-play-usb-audio-raspberrypi %})も段違いに快適。持っているUSBハブにHDMI出力機能があるので、TVを使って遊ぶことも可能。ナンテコッタ。

## Raspberry Piで使ってみる

MacのSteamストリーミングで存在意義が揺らいだMoonlight Embeddedが機能するRaspberry Pi。こいつはSteamコントローラが簡単に動かない。もし、Raspberry PiにLinux版SteamクライアントもしくはSteamOSがインストールできれば楽に使えたかもしれない。けれど、両者ともにARMプロセッサをサポートしていない。SteamリンクはARMプロセッサを使っているのに？疑問を持たないほうが幸せなこともある。Raspberry PiでSteamコントローラを動かしたい場合、[ynsta/steamcontroller][ynsta/steamcontroller]を利用することになる。

それで試した結果、動かせないこともないけど快適にプレイできない。XBOXコントローラの動作をエミュレートするので、Steamコントローラとして認識されないのが辛い。これではSteamコントローラを使うアドバンテージがまったくない。だったら親機であるPCにレシーバーを挿して、Raspberry Piはストリーミングを行うのみにした方が良い。これならSteamコントローラとして使える。

しかし、Macで快適ストリーミングができるということを考えると・・・。いやいや、試していないがSteamストリーミングではSteam以外のゲーム（OverwatchやDiablo3など）が遊べないのでは？試してみたらDiablo3をストリーミングできて、Steam以外のゲームもSteam経由ならばコントローラの設定が利用できるので普通に遊べてしまった。おおっと。

## それで

コントローラにしてはお値段がまあまあする。これより高いのはXBOX Eliteワイヤレスコントローラぐらいじゃないかな。キーアサインのカスタマイズが相当豊富なのでPCゲームをメインにプレイするなら試して見る価値はあり。

副作用としてストリーミングで遊びたければMacを使えば良いという新しい発見があった。なぜストリーミングにこだわるのか？椅子のおかげでケツが痛いからである。俺は寝っ転がってゲームをやりたいんだ。

<div class="amazon-block"><div class="image"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B017WHPVT8/count_0-22" target="_blank"><img src="http://ecx.images-amazon.com/images/I/41Uo6hEkQpL.jpg" /></a></div><div class="title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B017WHPVT8/count_0-22" target="_blank">STEAM CONTROLLER [並行輸入品]</a></div><div class="label">Valve Corporation</div><div class="binding">Video Game</div><div class="rank">Sales Rank: 409</div><a class="link" href="http://www.amazon.co.jp/exec/obidos/ASIN/B017WHPVT8/count_0-22">Amazonで詳細を見る</a></div>

[steamcontroller]:http://store.steampowered.com/app/353370?l=japanese
[ynsta/steamcontroller]:https://github.com/ynsta/steamcontroller
