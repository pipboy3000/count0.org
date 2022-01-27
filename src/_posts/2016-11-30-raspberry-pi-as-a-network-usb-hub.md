---
layout: post
title: VirtualHereでMacbookの足りないUSBポートを補う
categories: raspberrypi mac
---
MacbookにはUSBポートが一個しかなくて、それも電源供給に使われ、USBが使えない状態である。これはApple社の卓越した未来のビジョンを具現化したであろうMacbookのデザインなのでしょうがない。それを了解の上で買っているんだろ？ 西海岸からそんな声がする。私としてはAppleローン24回払い金利0％ありがとうござます。としか言えない。

さて、実際のところUSBがなくても今のところ困っていない。待っていればそのうちUSB 3.1かつUSB-PDかつUSB-C製品が市場に溢れるのではないかという楽観的予測を立てている。しかし、Appleはしれっと無かったことにする技術が長けている。予断は許されないと思いつつ昔、[別のPC、MACのディスクドライブを共有する機能](https://support.apple.com/ja-jp/HT203973)があったような。Sierraの「共有」設定にそんな項目ないのだが、あれのUSB版はないのだろうか。

そんなわけで調べたら[VirtualHere](https://virtualhere.com/)という製品がある。ネットワーク越しに別のPC、MACに繋がったUSB機器を扱える。これだ。

24時間起動している家のRaspberry Pi 2にVirtualHereサーバをインストールした。やり方は[FAQに書かれている](https://virtualhere.com/oem_faq)のを参考にしつつ、最近のRaspbianはsystemdなのでsystemdで起動するようにした。

サーバプログラムを入手して

```
wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm
sudo chmod +x ./vhusbdarm
sudo mv vhusbdarm /usr/sbin
```

`/etc/systemd/system/virtualhere.service`の内容を以下のようにして

```
[Unit]
Description=VirtualHere USB Sharing
Requires=avahi-daemon.service
After=avahi-daemon.service
[Service]
ExecStartPre=/bin/sh -c 'logger VirtualHere settling...;sleep 1s;logger VirtualHere settled'
ExecStart=/usr/sbin/vhusbdarm
Type=idle
[Install]
WantedBy=multi-user.target
```

daemonに登録してスタートさせる。

```
systemctl daemon-reload
systemctl enable virtualhere
systemctl start virtualhere
```

次に[Mac用VirtualHereクライアントソフト](https://www.virtualhere.com/usb_client_software)をダウンロードして起動する。サーバが正しく動いていればクライアントソフトにサーバが一覧表示される。

トライアル版なので同時に複数のデバイスを使うことはできないが、USBメモリー、Steamコントローラー、SDカードリーダー、ICレコーダーを問題なく扱うことができた。ポータブルHDDは認識しても正しくマウントできず。Raspberry Piの給電能力を超えているのが原因じゃないかと思われる。Shairport Syncで使っているUSBスピーカーは音が出なかった。試しつつ、近々で必要にならないのでまあいいかというところで落ち着いた。

ちなみにわざわざRaspberry Piを使っているがWindows版サーバもあるので、気軽に試すことができる。

後日別件で手に入れた[Steamリンク](http://store.steampowered.com/app/353380?l=japanese)の設定にVirtualHereと書かれていることを発見。これはVirtualHereを[Steamストアで購入](http://store.steampowered.com/app/440520/)するとSteamリンクをVirtualHereサーバとして使えるとのこと。ストアでゲーム以外も扱っているのは知っていたが、こんなものまで売っていることに驚いた。ちなみに評価は「賛否両論」のようだ。
