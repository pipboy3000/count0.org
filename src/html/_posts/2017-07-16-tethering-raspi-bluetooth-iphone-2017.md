---
layout: post
title: Raspberry PiからBluetoothを使ってiPhoneでテザリング 2017年版
categories: raspberrypi
---

[2014年にiPhoneとRaspberry PiをBluetoothを使ってテザリングするという記事](/2014/02/06/tethering-raspi-bluetooth-iphone.html)を書いた。この記事はそれの2017年版である。


## TL;DR

iPhoneとRaspberry Piをペアリングする。そしてbt-panでpan接続する。

## iPhoneとペアリング

Raspberry PiをGUIで操作していればツールバーのBluetoothアイコンから手軽にできるが、
あえてCLIのやり方だと

iPhoneを検出後、MACアドレスをコピーしてペアリングする。

``` bash
$ hcitool scan

Scanning ...
        XX:XX:XX:XX:XX:XX       iPhone

$ bluetoothctl
[bluetooth]# pair XX:XX:XX:XX:XX:XX
[bluetooth]# trust XX:XX:XX:XX:XX:XX
```

## bt-pan

BlueZの最新版ではbluez-simple-agentがなくなっているので、[bt-pan](https://github.com/mk-fg/fgtk#bt-pan)を利用する。このスクリプトは`bt-pan --help`や`bt-pan client --help`で使い方がわかる。

iPhone側で「インターネット共有」をONにしておくこと。

bt-panをダウンロードしたあと、実行権限を付与して

``` bash
$ wget https://raw.githubusercontent.com/mk-fg/fgtk/master/bt-pan
$ chmod +x bt-pan
```

iPhoneのMACアドレスを元に接続したり、切断したり。

``` bash
# 接続
$ bt-pan --debug client XX:XX:XX:XX:XX:XX

# 切断
$ bt-pan --debug client XX:XX:XX:XX:XX:XX -d
```

接続が成功していれば`ifconfig`を実行して`bnep0`というインターフェースにアドレスが割り振られている。

実際に通信できるか試したい場合はWifiをオフにするとよい。その代わりsshやvnc、RDPは切断される覚悟で。


## あとがき
2014年当時、興味本位のアイデアを実現できたので記事にしたが、その後Raspberry Piを外に持ち出してiPhoneでテザリングするなんていう酔狂な真似は一度もしなかった。

では、なぜ2017年版を書くか。それはあの記事がちょいちょいリンクされているからである。内情を晒すと、あの記事は2017年現在もこの小さな個人ブログでアクセスのある記事なのだ。かつてはあの記事からアフィリエイトしているBluetoothドングルがたくさん売れていた。良い時代であった。最近はさっぱりだ。

未だにアクセスがあるということは一定数の需要があるということと、今はBlueZが更新されてあの記事通りでは動かないということがわかったので、更新版を書いたのであった。

ただ、今回のために色々調べるとRaspberry PiはPixelデスクトップで簡単にBluetoothが扱えるようになっていたり、iPhone 7はBluetooth 4.2なので6LoWPANで接続できないか試してダメだったりで面白かった。

<div class="amazon-block"><div class="image"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B01NAHBSUD/count_0-22" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51FuxBMPonL.jpg" /></a></div><div class="title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B01NAHBSUD/count_0-22" target="_blank">Raspberry Pi 3 Model B V1.2 (日本製) 国内正規代理店品</a></div><div class="label">Raspberry Pi</div><div class="binding">Tools &amp;amp; Hardware</div><div class="rank">Sales Rank: 87</div><a class="link" href="http://www.amazon.co.jp/exec/obidos/ASIN/B01NAHBSUD/count_0-22">Amazonで詳細を見る</a></div>
