---
layout: post
title: Raspberry PiでUSBスピーカーをAirPlay対応する
categories: raspberrypi
---
本屋でヘッドフォンアンプ搭載Bluetoothユニットが付録についている「Olasonic完全読本」という本を見かけました。買いそうになったけど、我が家のOlasonicはUSBスピーカー。本の付録は使えない。というわけでRaspberry Piを使ってAirPlay対応を試しました。

## 材料
* Raspberry Pi Model B 512MB
OSはRaspberianで電源は<a href="http://www.amazon.co.jp/gp/product/B00GTGETFG/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00GTGETFG&linkCode=as2&tag=count_0-22">Anker 40W 5ポート USB急速充電器 ACアダプタ </a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B00GTGETFG" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />を使っています。
* USBスピーカー
<a href="http://www.amazon.co.jp/gp/product/B009NQKJEY/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B009NQKJEY&linkCode=as2&tag=count_0-22">Olsasonic TW-S5W</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B009NQKJEY" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
DAC内臓のUSBパワードスピーカー。いい音だします。
この記事のテーマを覆してしまいますが、
<a href="http://www.amazon.co.jp/gp/product/B00J2PVIY6/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00J2PVIY6&linkCode=as2&tag=count_0-22">Bluetooth版</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B00J2PVIY6" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />があります。

## USBスピーカーを接続する
Raspberry PiがUSBスピーカーを認識するか接続して確認します。幸いなことに認識されました。

```bash
pi@raspberrypi ~ $ aplay -l
**** ハードウェアデバイス PLAYBACK のリスト ****
カード 0: ALSA [bcm2835 ALSA], デバイス 0: bcm2835 ALSA [bcm2835 ALSA]
  サブデバイス: 8/8
  サブデバイス #0: subdevice #0
  サブデバイス #1: subdevice #1
  サブデバイス #2: subdevice #2
  サブデバイス #3: subdevice #3
  サブデバイス #4: subdevice #4
  サブデバイス #5: subdevice #5
  サブデバイス #6: subdevice #6
  サブデバイス #7: subdevice #7
カード 0: ALSA [bcm2835 ALSA], デバイス 1: bcm2835 ALSA [bcm2835 IEC958/HDMI]
  サブデバイス: 1/1
  サブデバイス #0: subdevice #0
カード 1: DAC [USB Audio DAC], デバイス 0: USB Audio [USB Audio]
  サブデバイス: 1/1
  サブデバイス #0: subdevice #0
```

USBスピーカーをデフォルトのオーディオデバイスにします。

### wheezyの場合

```bash
sudo vi /etc/modprobe.d/alsa-base.conf

# 以下のようにコメントする

options snd-usb-audio index=-2
  ↓
# options snd-usb-audio index=-2
```

### jessieの場合

``` bash
sudo vi /usr/share/alsa/alsa.conf

# 以下の行を書き換える。数字はaplay -lで表示されるUSBスピーカーの番号

defaults.ctl.card 1
defaults.pcm.card 1
```

再起動して設定を反映させます。

```bash
sudo reboot
```

## shaiportをインストール
[shairport][shairport]はAirTunesのエミュレータです。これが肝です。パッケージで提供されていないので、ソースコードからビルドします。

Raspberry Piにはビルドに必要なbuild-essentialは予めインストールされているはずです。

その他必要なパッケージをインストールします。

```bash
sudo apt-get install git libssl-dev libavahi-client-dev libasound2-dev
```

ソースを落としてきてビルドします。

```bash
git clone https://github.com/abrasive/shairport.git
cd shairport/
./configure
make

# ビルドされたshairportを実行。-aオプションで名前はご自由に。
./shairport -a "RasPi"
```

Raspberry Piと同じLANに接続しているiPhone、iTunesからRasPiという名前のAirPlayスピーカーが見つかり接続、再生して音が鳴れば成功です。

![iTunesでAirPlayに接続](/images/airplay-usb-audio-raspberrypi_2.jpg)

## 起動時にshairportを起動する(daemon化)
毎回手動でスクリプトを実行するのは面倒なので、daemon化します。

すでにビルド済みなので`make install`で`/usr/local/bin/`にshairportをインストールします。

```bash
cd shairport
sudo make install
```

続いてshairportのscriptsフォルダに起動スクリプトがあるので、コピーして使います。

```bash
sudo cp ~/shairport/scripts/debian/default/shairport /etc/default/
sudo cp ~/shairport/scripts/debian/init.d/shairport /etc/init.d/
```

`/etc/default/shairport`を編集してAirPlayで表示される名前を編集します。名前を指定しない場合はホスト名が使われます。

```bash
sudo vi /etc/default/shairport

AP_NAME='RasPi'
```

コピーした`/etc/init.d/shairport`の中身を見るとユーザー追加のコマンドを実行してねと書かれていたので、ユーザーshairportをaudioグループに追加します。

```bash
sudo useradd -g audio shairport
```

起動時にshairportが動くようにupdate-rc.dに登録します。そして再起動します。

```bash
sudo update-rc.d shairport defaults
sudo reboot
```

再起動後、AirPlayにつなげて音楽が再生されれば成功です。

![iPhoneでAirPlayに接続](/images/airplay-usb-audio-raspberrypi_1.jpg)

## 音量に注意
iTunesでAirPlay接続した際、ボリュームの設定がおかしくて爆音が鳴りびっくりしました。

Raspberry PiにログインしてalsamixerでdBゲインを調整しました。

```bash
alsamixer
# 下の画像のような画面がでます。
```

![alsamixerでdBゲインを調整](/images/airplay-usb-audio-raspberrypi_3.jpg)

そしてiPhone / iTunesの音量はかなり抑えめで、ちょうどいい音量になりました。

arch linux wikiに「[サウンドの品質が悪い時は][archlinux wiki alsa]」の項でゲインを0にするといいよと書かれていますが、これは怖くてできない。

[olasonic books]:http://www.olasonic.jp/press/201405supplement_press.html
[shairport]:https://github.com/abrasive/shairport
[model b plus]:http://www.raspberrypi.org/products/model-b-plus/
[archlinux wiki alsa]:https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture_(%E6%97%A5%E6%9C%AC%E8%AA%9E)#.E3.82.B5.E3.82.A6.E3.83.B3.E3.83.89.E3.81.AE.E5.93.81.E8.B3.AA.E3.81.8C.E6.82.AA.E3.81.84
