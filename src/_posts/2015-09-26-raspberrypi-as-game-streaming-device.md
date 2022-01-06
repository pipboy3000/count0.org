---
layout: post
title: Raspberry PiでMoonlight Embeddedを使ってゲームストリーミングする
categories: raspberrypi
---
<a href="http://www.amazon.co.jp/gp/product/B0053EZEY0/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B0053EZEY0&linkCode=as2&tag=count_0-22">ほぼ踏み台の椅子</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B0053EZEY0" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />で長時間PCゲームをしているとケツが痛くてしょうがないです。TVとPCを繋げばいいんですけど、配線や部屋のレイアウト的に厳しい。そういや[以前試したSteam OS]({% post_url 2014-05-18-install-steam-os %})で古いPCでも快適にストリーミングできたぞ。というわけでRaspberry Pi 2を使ってPCで動いているSteamをテレビにストリーミングしてみます。

## 材料

* HDMI端子のあるテレビ
* GeForce 650以上のグラフィックボードを搭載し、GeForce ExperienceがインストールされたPC(詳しい必要スペックは[コチラ][nvidia_gamestreaming]から)
* <a href="http://www.amazon.co.jp/gp/product/B004DL20UU/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B004DL20UU&linkCode=as2&tag=count_0-22">Xbox 360 コントローラー (有線)</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B004DL20UU" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
* <a href="http://www.amazon.co.jp/gp/product/B00TBKFAI2/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00TBKFAI2&linkCode=as2&tag=count_0-22">Raspberry Pi 2 Model B</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B00TBKFAI2" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
  * OSはRaspbian
  * HDMIケーブル
  * 有線LANケーブル（安定性のため推奨）
  * 電源(ダイソーでUSBケーブルとUSB電源アダプタで計400円)

わざわざGeForceと指定しているのはワケがあって、Steamのゲームストリーミング機能を使うのではなく、NVIDIAのGAMESTREAMを利用するのです。つまりRaspberry Piで[Steamリンク][steamlink]相当の物を作るのではなく、[NVIDIA SIELDデバイス][nvidia_sield]を作るのです。だから、GeForce Experienceにリスト表示される非Steamゲームもストリーミングできます。

以下の操作は全てSSHで行いました。

## XBOX360コントローラー
Raspberry PiでXBOX360コントローラーを使えるようにします。コントローラーを使わない場合はこの項目を飛ばしてもOKです。

まずxpadを無効にします。

``` bash
sudo modprobe -r xpad
```

/etc/modprobe.d/gamepad.conf（多分存在しないので作る）に以下の内容を書き込みます。

``` bash
# /etc/modprobe.d/gamepad.conf
blacklist xpad
```

そしてxpadの代わりに[xboxdrv][xboxdrv]をインストールします。

``` bash
sudo apt-get install xboxdrv
```

動作テストをします。コントローラーをいじくり回すと、それに応じてコンソールに情報が出力されます。Ctrl + Cでテストをやめます。

``` bash
sudo xboxdrv
```

起動時にxboxdrvが有効になるように/etc/rc.localを編集します。

``` bash
# /etc/rc.local
xboxdrv --trigger-as-button --wid 0 --led 2 --deadzone 4000 --dpad-rotation 90 --axismap -DPAD_X=DPAD_X --silent &
```

そして再起動します。

``` bash
sudo reboot
```

コントローラーを2本、3本とつなげたい場合や、/etc/rc.localではなくdaemonで運用したい場合は[Retro-Piのこのページ][retro-pi-controller]を参照してください。XBOX360以外のコントローラーを使いたい場合は[Arch Linux Wikiのゲームパッド][arch-wiki-gamepad]を参考にするといいのではないでしょうか。

## Moonlight Embedded
NVIDIA GAMESTREAMのオープンソース実装であるMoonlight EmbeddedをRaspberry Piにインストール、設定していきます。

パッケージが用意されているので、まずは/etc/apt/source.listに追記します。

``` bash
# /etc/apt/source.list
deb http://archive.itimmer.nl/raspbian/moonlight wheezy main
```

そしてパッケージをインストール。

``` bash
sudo apt-get update
sudo apt-get install moonlight-embedded
```

次に親機であるPCとペアリングします。

``` bash
moonlight pair 192.168.0.8 # ペアリングしたいPCのIPアドレスもしくはavahiのホスト名)
```

PINコードが表示されます。親機のGeForce Experienceが入力受け付け状態になるので、PINコードを打ち込み認証が成功すればペアリングは完了です。

どんなゲームがストリーミングできるか一覧表示します。

``` bash
moonlight list
```

ストリーミングする前に注意点が。moonlightがインストールしたコントローラーのキーマップ(/usr/share/mappings/xbox360.conf)は2015年9月時点で実用的ではないです。しかし[GitHubにPull Requestが上がっていて][moonlight-pr]、それは修正されているので使えます。将来的に本体にマージされるけど、今はPRのキーマップをダウンロードして使います。

``` bash
# キーマップをダウンロード
wget https://raw.githubusercontent.com/vinanrra/moonlight-embedded/master/mappings/xbox360.conf
# キーマップを指定してストリーミング
moonlight stream -mapping xbox360.conf -app Steam 192.168.0.8
```

ペアリングした後は親機のIPを指定しなくても自動で探してくれるようですが、時折IPv6になってしまい親機を探せないことがあったので、IPもしくはホスト名を指定しておくのが無難です。

その他のオプションは以下のコマンドで確認できます。

``` bash
moonlight -h
```

オプションをファイル形式で保存しておくと便利です。毎回オプションを指定する必要がなくなります。

``` bash
mkdir ~/hosts

# 設定ファイルの名前はhosts/親機のIPもしくはホスト名.conf
# デフォルトの設定ファイルをコピーして使います。
cp /usr/etc/moonlight.conf ~/hosts/192.168.0.8.conf

# 設定ファイルの編集
vi ~/hosts/192.168.0.8.conf

# 次からは
moonlight stream 192.168.0.8

# IPの指定を省略すると
moonlight stream
```

``` bash
# 192.168.0.8.conf 設定例
app = Steam
mapping = ./xbox360.conf
```

## 試してみて
GTA5、METAL GEAR SOLID5がストレスなくプレイできました。ソファでくつろぎながらゲームができる！ htopで負荷を確認したらload averageは高い時で0.4程度でした。

## 無線LANで試してみた。
思ったよりもラグはなかったです。その時試していたゲームはDon't Starveだったのでラグがあっても気にならなかったのですが、FPSなどシビアなタイミングを要求されるジャンルはイラつくかもしれないです。すぐに有線LANに戻しました。また、部屋を跨いだ無線LANだと体感が変わってくるかと思います。

## トラブルシューティングや問題点

### 音が出ない
最初、ストリーミングはうまくいったけど全く音がでない。確認のコマンドを実行するとテレビから音が鳴る。なぜ。テレビが古いから？

``` bash
speaker-test -c2 -l1 -t sin -f440 
```

原因はPC側でBluetoothスピーカーに接続していたからでした。他の音声出力デバイスに変更したらストリーミングで音がでました。

### ストリーミングが止まる
Don't Starveをプレイしていると一定間隔で画面のストリーミングが止まります。これは親機のPCがモニターをスリープするタイミングで画面も固まっていました。逆にMETAL GEAR SOLID5は止まることがなかったのでゲームによって違いがあるかも。モニターのスリープ時間を変えることで回避しました。

### ゲームの文字が小さい
PCモニタ向けに作られたPCゲームなのでしょうがない。TVの都合で解像度は1280×720に下がっていますが、それでも小さい。メガネをかけてゲームします。

[steamlink]: http://store.steampowered.com/universe/link/?l=japanese
[nvidia_gamestreaming]: http://shield.nvidia.co.jp/play-pc-games/
[nvidia_sield]: http://shield.nvidia.co.jp
[moonlight-embedded]: https://github.com/irtimmer/moonlight-embedded
[retro-pi-controller]: https://github.com/RetroPie/RetroPie-Setup/wiki/Setting-up-the-XBox360-controller
[xboxdrv]: http://pingus.seul.org/~grumbel/xboxdrv/
[moonlight-pr]: https://github.com/irtimmer/moonlight-embedded/pull/209
[arch-wiki-gamepad]: https://wiki.archlinuxjp.org/index.php/ゲームパッド
