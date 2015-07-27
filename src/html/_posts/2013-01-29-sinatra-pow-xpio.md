---
layout: post
title: sinatra, pow, xip.io
categories: ruby
---
sinatraでスマホ向けに何か作る場合、実機で確認したいという欲求を満たしたいと思うけど、[pow](http://pow.cx/)と[xip.io](http://xip.io/)を使うと簡単に実現できる。

前提条件はpowはインストール済みで、sinatraをgemかbundlerでインストール済みであること。xip.ioを利用する際に必要な登録などはない。

適当にsinatraアプリを作る

``` bash
	mkdir ~/sampleapp
	cd ~/sampleapp
```

web.rb

``` ruby
	require "sinatra"
	
	get '/' do
		"Hello, world"
	end
```

config.ru

``` ruby
	require "./web.rb"
	
	run Sinatra::Application
```

powにsymlink張る。pathは自分の環境に置き換えて。

``` bash
	cd ~/.pow
	ln -s /path/to/sampleapp
```

ブラウザで見れるか確認

	http://sampleapp.dev/

開発機のipを調べる。例えば10.0.0.4とするとxip.io経由では下記のように

	http://sampleapp.10.0.0.4.xip.io/

iPhoneでアクセスする。

## 注意点など
* xip.ioで確認したいデバイスはLANがいい。  
DNSがxip.ioの名前解決ができなければ当然みれない。auのLTE iPhone5では見れなかった。自宅の無線LAN経由では見れた。  
あと、Google Public DNS経由の方がつながりがよいので、LAN環境でも見れない場合はGoogle Public DNSにしてみるといい。プライマリが8.8.8.8でセカンダリが8.8.4.4のやつ。
* GUIでpowならAnvil  
もし、GUIでpowを操作したいなら[Anvil](http://anvilformac.com/)がオススメ。
