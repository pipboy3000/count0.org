---
layout: post
title: Dropbox Core API(ruby)でproxyを使う
categories: ruby
---
Rubyの[Dropbox Core API](https://www.dropbox.com/developers/core)をproxy経由で使う方法です。

ドキュメントを読んでもproxyの設定方法は書かれていませんでした。しかし、Dorpbox Core APIはNet::HTTPを使っているので、環境変数に`http_proxy`が設定してあれば自動で使うようです。OSXやLinuxならば.bashrcあたりに書いておけばいいでしょう。

``` bash
export http_proxy='http://hoge.proxy.com:8080'
```

Windowsの場合はマイコンピューターを右クリックしてから設定する環境変数を使えばいいのでしょうが、プログラムに直接書いてしまいます。

``` ruby
ENV['HTTP_PROXY'] = 'http://hoge.proxy.com:8080'

# 以下Dropbox Core APIのコード
```

この方法、Dropbox Core APIに限らずNet::HTTPを使っているのものであれば通用します。自分がよく使う範囲ですと、BundlerやNokogiriです。

