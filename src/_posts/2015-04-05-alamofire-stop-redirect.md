---
layout: post
title: Alamofireでリダイレクトして欲しくない
categories: swift ios
---
Alamofire v1.2.0において、この記事で言及しているプルリクエスト相当のコードがマージ追加されました。よって、この記事自体がdeprecatedです。そしてAlamofireでリダイレクトさせたくない場合は以下のコードで済みました。

<script src="https://gist.github.com/pipboy3000/0936feea944711939091.js"></script>

## 以下古い記事
Alamofire(v1.1.4)でHTTPステータスコードに従ってリダイレクトして欲しくないというレアケースかもしれない事態があって、こいつをどうするかという話です。

リダイレクト処理の実装サンプルは[公式のドキュメント][handling_redirect]にあって、`NSURLSession`の場合 `URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:`をdelegateで実装すればよくて、リダレクトさせたくない場合は前述のとても長いメソッドのcompleteHandlerで`nil`を返せばいいみたい。例えば以下のようなコード。

<script src="https://gist.github.com/pipboy3000/e6cb0253770e97450225.js"></script>

Alamofireのソースコードを眺めると、`Alamofire.Manager.delegate`がprivateに設定されている。ソースを触る必要があるかなと思案していたら、[pull request][no_redirect_pr]にprivateなメソッド、プロパティをpublicにして外側からいじれるようにしているのが上がっていた。これを使うと以下のように書ける。

<script src="https://gist.github.com/pipboy3000/354a0f47e71c8617b5e6.js"></script>

cocoapodsでこのpull requestを使いたい場合はリポジトリとcommitを指定すればOKでした。

``` ruby
pod 'Alamofire', :git => 'https://github.com/jhersh/Alamofire.git', :commit => 'bbdee79eefff2fc4f57f392f6494473538850fae'
```

pull requestが取り込まれたり、別の実装方法が採用されるまでは、当分はこれでOK。

## 参考リンク

* [Alamofire][alamofire]
* [Handling Redirects and Other Request Changes][handling_redirect]
* [jhersh/Alamofire][no_redirect_pr]

[handling_redirect]: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/URLLoadingSystem/Articles/RequestChanges.html
[no_redirect_pr]: https://github.com/jhersh/Alamofire/commit/bbdee79eefff2fc4f57f392f6494473538850fae
[alamofire]: https://github.com/Alamofire/Alamofire
