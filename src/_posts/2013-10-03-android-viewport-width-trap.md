---
layout: post
title: Android 4で改行位置が狂う
categories: css
---
レスポンシブ対応をする必要があるページにviewportを記述したのですが、Android 4.1のブラウザで不具合が。

[サンプルページ](http://cdpn.io/dehwx)

コンテンツエリアの横幅が600pxなので、スマホで閲覧した際、左右に若干の余白が表示されるように下記のviewportを記述しました。

``` html
<meta name="viewport" content="width=650,target-densitydpi=device-dpi">
```

Android 4.1のブラウザだと1. plain p elementの文章が途中で改行されます。viewportの値をdevice-widthに設定すると文章が意図しない位置で改行するということはなくなります。しかし、iOSのsafariで意図しない表示結果になってしまいます。実に困りものです。

同僚にまで検索を手伝ってもらい解決方法が書かれたページを発見しました。

[【Android】4系で幅が効かずに空白ができることがある件について](http://mania-ku.info/?p=304)

自分の場合、viewportの設定をがんばるのではなく、pタグにcssで1pxの透明gifを設定することにしました。わざわざ1pxのgifを用意するのも面倒なので、Data URIを使いました。

``` scss
$glass: "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==";

p.with-background {
  background-image: url($glass);
}
```

意図しない位置で改行されなくなりました。しかし、legacy IEで嗅いだことのあるバッドノウハウな香りがします。シンプルなページを作れば崩れることもないだろうという考えを一蹴するバグでした。ちなみにAndroidのChromeでは再現しませんでした。

