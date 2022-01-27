---
layout: post
title: Raspberry Pi
categories: raspberrypi
---
届いたのはRaspberry Pi Type Bの256MBです。注文した時期が悪くて512MBが発表された頃に届きました。

よろしい、Arch Linuxだ。と意気込みだけは立派だったが、慣れているDebian系とは違い躓くことがたくさんありました。結局はRaspbianに変更するはめに。

初回起動時、もしくは`raspi-config`のメニュー`expand_rootfs`でSDカードの容量全て使えるようにしました。1時間はかかりました。

ログイン後、`startx`でGUI環境を起動しました。もっさりといった印象でした。どうしてもGUIが使いたいという時でない限りssh(CUI)で十分です。LOCALEは設定していないので、すべて英語でしたが、問題なしです。

### wifiの設定で躓く
使用したwifiアダプタはプラネックスの<a href="http://www.amazon.co.jp/gp/product/B00ESA34GA/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00ESA34GA&linkCode=as2&tag=bakuonblog-22">GW-USNANO2</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=bakuonblog-22&l=as2&o=9&a=B00ESA34GA" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />です。ググるとドライバーからインストールしなければいけないという記事もありましたが、自分が使ったRaspbianではwifiのドライバをインストールしなくても認識しました。

しかし、ifconfig -aで確認したところIPアドレスが振られていませんでした。GUI環境であるLXDEのデスクトップにあったwifi設定のアプリケーションがありましたが、デバイスを認識しなかったため、結局`/etc/network/interface`にdhcpでIPを取得するように設定し`/etc/init.d/networking restart`でめでたくIPアドレスがふられました。

### その後
もう一枚SDカードを用意し、懲りずにArch Linuxに挑戦しました。その時に[Arch Linux Wiki][1]を読みあさり、色々勉強になりました。余計なものが動いていない分起動が早いです。

また、[NOOBS](http://www.raspberrypi.org/downloads)の登場でインストールが簡単になりました。

[1]: https://wiki.archlinux.org/index.php/Main_Page_(%E6%97%A5%E6%9C%AC%E8%AA%9E)
