---
layout: post
title: Raspberry Pi
categories: raspberrypi
---
届いたのでいぢってみた。

### Arch Linuxは難しい
よろしい、Arch Linuxだ。と意気込みだけは立派だったが、Debian系に慣れているので、Raspbianに変更した。つまりはSDにイメージを書き込むところからやり直した。

### TV出力は字が小さい
シャープのTVにつなげたが、HDのテレビにコンソールの文字は厳しい。
GUI環境でも文字が小さくて、相当近づかないと読めない。

### Raspbianに変える
起動がArch Linuxより遅いかな。apt-getは偉大。
startxでLXDEが起動した。

### SDカードの容量を目一杯使うようにする
初回起動時か、raspi-configでメニューに入る。そこからexpand_rootfsでSDカードの容量すべてを使えるようにしてくれる。1時間以上はかかった。

### GUI環境が遅い
もっさりした印象。アプリケーションを立ち上げるのに時間がかかる。sshで操作すればいいと思っていたので、結構どうでもいいポイント。
LOCALEは設定していないので、すべて英語。特に問題なし。

### wifiの設定で躓く
使用したwifiはプラネックスのGW-USNano2-M。仕事帰りにソフマップで買ったやつ。

ググるとドライバーからインストールしなければいけないという記事がちらほらあるが、自分が使ったRaspbian 2012-09-18-wheezy-raspbianはwifiのドライバをインストールしなくても認識した。

ifconfig -aで確認したが、IPアドレスはふられていなかった。

LXDEのデスクトップにあったwifi設定のアプリケーションではアダプタを認識せしないため、結局/etc/network/interfaceにdhcpするよう設定を書きこみ/etc/init.d/networking restartでめでたくIPアドレスがふられた。

### いぢってみて
Arch Linuxには再挑戦したい。

