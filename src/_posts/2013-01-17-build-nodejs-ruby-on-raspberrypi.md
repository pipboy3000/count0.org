---
layout: post
title: Build node.js, ruby on raspberry pi
categories: raspberrypi
---
### 環境
Raspberry Pi Model B 256MB

### 注意点
どちらもビルドに2時間はかかると思っていい。

### Node.js
あえてソースからのビルド。以前はややこしかったNode.jsのビルドだけど、今はいたって簡単。

``` bash
	apt-get install python build-essential
	mkdir ~/nodejs
	cd ~/nodejs
	wget -N http://nodejs.org/dist/node-latest.tar.gz
	tar xzvf node-latest.tar.gz
	cd node-v*
	./configure
	make
	sudo make install
```

### Ruby
リンク先を参照。

[Compiling and installing ruby on the raspberry pi using rbenv…](http://blog.pedrocarrico.net/post/29478085586/compiling-and-installing-ruby-on-the-raspberry-pi-using)

apt-getでRubyをインストールした後にrbenvで再度rubyをインストールしている。

Change your memory split to CPU 224/32 VRAM usingの部分はraspi-config側が変更されたので、設定画面で32と入力する。これはVRAMにどれだけもメモリを割り当てるかという意味。
