---
layout: post
title: Raspberry PiからBluetoothを使ってiPhoneでテザリング
categories: raspberrypi
---
Raspberry Pi Type Bの256MBは持っていたのですが、物欲が暴走して<a href="http://www.amazon.co.jp/gp/product/B00CBWMXVE/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00CBWMXVE&linkCode=as2&tag=count_0-22">Type B 512MB</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B00CBWMXVE" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />を[MOD MY PI][1]で手に入れました。
<a href="http://www.amazon.co.jp/gp/product/B00EHV05VW/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00EHV05VW&linkCode=as2&tag=count_0-22">Pibow Ninja</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B00EHV05VW" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />とセットで送料込みの$68でした。

このRaspberry Piを鞄に忍ばせ、外出先でiPhoneのテザリングを使って通信ができると素敵かもしれないと思ったので、iPhoneとテザリングできるようにしました。

OSはRasbian。NOOBSを使い簡単にインストールしました。USB Bluetoothアダプタは<a href="http://www.amazon.co.jp/gp/product/B0071TE1G2/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B0071TE1G2&linkCode=as2&tag=count_0-22">BT-MICRO4</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B0071TE1G2" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />を使いました。特別なことをしなくても起動時に認識します。

## Bluetoothの設定
[BlueZ][4]がLinuxでよく使われているようです。

``` bash
sudo apt-get update
sudo apt-get install bluetooth bluez-utils bluez-compat
```

身近なBluetoothデバイスをスキャンします。

``` bash
hcitool scan
```

デバイスが検出されたら、MACアドレスとデバイス名が表示されます。MACアドレスは後々使うので、コピーかメモを残すことをオススメします。

## Bluetoothキーボードを接続する
<a href="http://www.amazon.co.jp/gp/product/B004I23KEE/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B004I23KEE&linkCode=as2&tag=count_0-22">Riitek Rii mini Bluetooth keybord RT-MWK02</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B004I23KEE" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />というBluetoothキーボード接続します。余談ですが、[Kicksterterで資金を募っていたKano][2]のキーボードだけ欲しいです。

キーボードをペアリングします。以下sshで作業します。

``` bash
sudo bluez-simple-agent hci0 XX:XX:XX:XX:XX:XX # XX:XX:XX...はMACアドレス
```

PINコードの入力を聞かれるので適当な番号を4桁ほど入力します。(自分でPINコードを決めるのです。)  
その後、ペアリングしたいキーボードでPINコードを入力し、Enterキーを押します。

さらに再起動してもペアリングを保持するには

``` bash
sudo bluez-test-device trusted XX:XX:XX:XX:XX:XX yes
sudo bluez-test-input connect XX:XX:XX:XX:XX:XX
```

一連の作業を通してGUIのBluetooth接続が如何に便利なものか実感できます。

## iPhoneとBluetooth接続する
iPhone側の準備として、設定から`モバイルデータ通信`をオンに、`Bluetooth`をオンにしてBluetooth経由でテザリングができるようにしておきます。

``` bash
hcitool scan # iPhoneのMACアドレスを取得
sudo bluez-simple-agent hci0 XX:XX:XX:XX:XX:XX # ペアリング
```

ペアリングで失敗します。解決方法はbluez-simple-agentを少々修正します。  
`capability = "KeyboardDisplay"`を`capability = "DisplayYesNo"`に書き換えます。  
以下のコマンドかエディターで書き換えます。

``` bash
sudo perl -i -pe 's/KeyboardDisplay/DisplayYesNo/' /usr/bin/bluez-simple-agent
```

再度ペアリングを試みるとPINコードのかわりに`Yes/No`になります。ここで`yes`を入力してペアリングします。iPhone側でも許可ペアリングを許可します。そしてペアリングを保持します。

``` bash
sudo bluez-simple-agent hci0 XX:XX:XX:XX:XX:XX # ペアリング
sudo bluez-test-device trusted XX:XX:XX:XX:XX:XX yes
```

## テザリング
ペアリングとテザリングが成功すると`bnep0`というインターフェイスになるので、予め設定を書き込んでおきます。そしてPAN接続でテザリングです。

``` bash
echo "echo 'iface bnep0 inet dhcp' >> /etc/network/interfaces" | sudo sh
sudo pand -c XX:XX:XX:XX:XX:XX -role PANU --persist 30
```

テザリングできている場合は`bnep0`にIPアドレスが振られています。`ifconfig`で確認できます。

``` bash
ifconfig bnep0
```

そして、起動時にテザリングができる場合は自動接続するように`/etc/rc.local`にPAN接続のコマンドを記述しておきます。

``` bash
pand -c XX:XX:XX:XX:XX:XX --role PANU --persist 30

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

exit 0
```

`eth0`もしくは無線LANで`wlan0`のインターフェイスが優先されるようで、どちらも接続されていない時に`bnep0`が通信に使われました。これはmetricの値を変更すれば良いと思いますが、ここまで設定して力尽きました。

### 参考
* [Raspberry Pi Bluetooth iPhone Tethering - blog.wolfteck.com][5]
* [Raspberry Pi 無線LANとBluetoothの隣接は可能？ - Homebrew.JP][6]

[1]: https://www.modmypi.com/
[2]: https://www.kickstarter.com/projects/alexklein/kano-a-computer-anyone-can-make
[3]: http://blog.kugelfish.com/2012/10/look-ma-no-wires-raspberry-pi-bluetooth.html
[4]: http://www.bluez.org/
[5]: http://blog.wolfteck.com/projects/raspi/bluetooth-iphone-internet/
[6]: http://homebrew.jp/show?page=1464
