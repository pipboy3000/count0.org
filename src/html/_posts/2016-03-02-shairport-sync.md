---
layout: post
title: ShairportからShairport Syncに乗り換える
categories: raspberrypi
---
今更感があるけどiOS9でAirplayの仕様が変更されたという情報を最近知って、アレもそうかなと思ったので、識者に聞いてみたらアレはそうだという話をしたのでした。アレとはiPhoneでRaspberry PiのリモートスピーカーにAirplayで繋いで曲を再生している時に「⏩(次の曲)」をタップするとAirplayが切断してしまうことです。ちなみに連続再生で次の曲に行く場合この切断はないのです。

この症状、iTunesだと発生していたのか記憶が定かではないが、最近iPhone + リモートスピーカーで再生する機会があり気づいたのだ。知らぬが仏です。

そして[Raspberry PiでAirplayしているのはShairport]({% post_url 2014-10-30-air-play-usb-audio-raspberrypi %})。メンテナンスは終わっている。しかし、このAirplay問題をクリアしたShairport Syncがあるではないか。こいつに乗り換えるのです。

## Shairpot Syncをインストール
Raspberry Pi B+でOSはRaspbian Jessie Lite、USBスピーカーは[OlasonicのTW-S5][speaker]です。手順は[Shairport SyncのREADME][shairport-sync]のとおりです。

> この記事を書いたあと、READMEが大幅に更新されているのでインストール、設定手順は本家READMEを参考にすることを強くオススメします。

すでにインストール済みのパッケージも幾つかあるかもしれませんが、以下のパッケージをインストールします。

```bash
sudo apt-get install autoconf automake libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev libsoxr-dev libssl-dev
```

ソースコードをダウンロードしてビルドします。

```bash
git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -i -f
./configure --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-soxr --with-systemd
make
```

`shairport-sync`のユーザーとグループを追加します。ユーザーは`audio`グループにも追加します。

```bash
getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null
```

そして、インストールです。

```bash
sudo make install
```

OS起動時にShairport Syncも立ち上がるようにします。

```
sudo systemctl enable shairport-sync
```

## 設定

ものすごくたくさんの設定項目がありますが、変更したのは`general`の`name`ぐらいです。

```bash
sudo vi /etc/shairport-sync.conf

# nameだけ編集する

general = {
  name = "RasPi"
  # 以下略
```

デフォルトオーディオデバイスは以前Shairportをインストールした時に以下のようにUSBスピーカーにしてあったので`shairport-sync.conf`でどのオーディオデバイスを使うかはいじっていません。

``` bash
sudo vi /usr/share/alsa/alsa.conf

# 以下の行を書き換える。数字はaplay -lで表示されるUSBスピーカーの番号

defaults.ctl.card 1
defaults.pcm.card 1
```

## 起動して聞きくらべ
`sudo reboot`で再起動してShairport Syncが動くのですが、ちょっと試してみたいことがあったので、その場でShairport Syncを起動しました。

```
sudo systemctl start shairport-sync.service
```

何を試したかったかというと設定の`general`の`interpolation`の項目で指定する`basic`と`soxr`の違いです。The SoX resamplerでsoxr。なんか音を良くしてくれそうな感じです。shairport-sync.confの説明を読む限り、CPU負荷が高そうです。プロセスのCPU利用率を比べてみたら`basic`の場合15％程、`soxr`の場合は40％以上です。高負荷！

それで、音の方はどうか？ たぶん`soxr`の方がいいんじゃない？ という感じです。あんまり自分の耳に自信ないんです。若いときはギターウルフとかのライブで耳に負荷をかけていたので。いい思い出です。

いいんじゃない？ の根拠は[Daft PunkのRandom Access Memories][ram]や[Tame ImpalaのCurrents][currents]を聞きくらべたときですね。ここら辺は感覚とCPU負荷のトレードオフでお好みに。

[shairport-sync]: https://github.com/mikebrady/shairport-sync
[ram]: http://www.amazon.co.jp/exec/obidos/ASIN/B00C061I3K/count_0-22
[speaker]: http://www.amazon.co.jp/exec/obidos/ASIN/B009NQKJEY/count_0-22
[currents]: http://www.amazon.co.jp/exec/obidos/ASIN/B00XBWBWBK/count_0-22
