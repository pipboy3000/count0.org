---
layout: post
title: Time CapsuleのHDDが壊れた
categories: mac linux
---
仕事を終えて部屋に戻り、Ino Hidefumiのクライ・ミー・ア・リヴァーを聴いて歌っていたら、レコードのような音飛びしたあとiTunesが沈黙しました。昔iPodでも同じような症状に遭遇したことがあり、嫌な予感。iTunesライブラリがあるのはTime Capsule。AirMacユーティリティで確認すると「内蔵ディスクを修復する必要があります」と表示されていました。HDDが逝かれていました。

Time Capsuleにあるデータで一番重要なのがiTunesライブラリ。つまり音楽です。覚えているだけでも200枚を超えるアルバムがデジタルデータとして保存されているのです。これをまたCDからリッピングする作業を考えると。mp3だけでも救出したい。色々試してみました。

## Time Capsuleを解体し、HDDをディスクユーティリティで診断、修復してみる
[Time Capsule：びぼうろぐ：So-netブログ](http://bibo-log.blog.so-net.ne.jp/archive/c2301125764-1)を参考に解体しました。解体するとAppleの保証はなくなります。底面のゴムは素手で、あとはプラスドライバーがあれば簡単に解体できます。

![こじ開けられたTime Capsule](/images/timecapsule-hdd-crash1.jpg)

HDDを取り出し、手持ちの裸族のお立ち台へセット。ディスクユーティリティを立ち上げるとNASのパーティションだけ灰色の文字でアクティブではありませんでした。マウントできません。検証をすると修復の必要あり、修復を試みると修復できませんと結果がでました。解体時参考にしたブログ[故障したTime Capsuleからデータを救い出す方法：びぼうろぐ：So-netブログ](http://bibo-log.blog.so-net.ne.jp/2010-03-08)を見るとData Rescue 3なるソフトがどうにかしてくれそうな感じですが、有料ということもあり別の手段でなんとかしてみようと思いました。

## macでddrescue
調べると[ddrescue](https://ja.wikipedia.org/wiki/Ddrescue)は復旧に使えると。善は急げとAmazonで<a href="http://www.amazon.co.jp/gp/product/B009KX65YI/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B009KX65YI&linkCode=as2&tag=count_0-22">2TBのHDD</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B009KX65YI" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />を注文、翌日到着なので、ソフマップで<a href="http://www.amazon.co.jp/gp/product/B001K97W56/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B001K97W56&linkCode=as2&tag=count_0-22">HDDを接続する機器</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B001K97W56" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />購入し、準備OK。ddrescueはhomebrewでインストールできました。詳しい使い方は[Ddrescue - Forensics Wiki](http://www.forensicswiki.org/wiki/Ddrescue)や[DataRecovery - Community Ubuntu Documentation](https://help.ubuntu.com/community/DataRecovery)を参照しました。

```bash
brew install ddrescue # インストール
sudo ddrescue -f -n /dev/disk2 /dev/disk3 resuce.log
```

Ctrl-Cで中断できます。レジュームする際は

```bash
sudo ddrescue -C -f -n /dev/disk2 /dev/disk3 resuce.log
```

USB2.0なので秒速6MBしかでません。2TB処理するのにざっと見積もって3日かかります。

## Ubuntuでddrescue
遅すぎるので速度の出る方法を考えました。主にゲームに使っているWindows PCのSATAを使います。

Windows 7で[UNetbootin](http://unetbootin.sourceforge.net/)を使いUSBスティックにUbuntu 13.04 Desktopを入れレスキューディスクとします。次にPCの内蔵HDDを2つとも引っこ抜き、Time Capsuleに入っていた壊れたHDDと新しいHDDをSATAでつなぎます。PCを再起動しブートメニューからUSBを選択し、LiveセッションでUbuntuを起動します。

![SATAにつながった2台のHDD](/images/timecapsule-hdd-crash2.jpg)

Ubuntuにはddrescueがないためインストールし実行します。

```bash
sudo apt-get update;sudo apt-get install gddrescue
sudo ddrescue -f -n /dev/sda /dev/sdb resuce.log
```

なんと秒速110MBも出ます。エクストリームな方法ですが、あとは結果待ちです。

## ddrescueではだめ
一晩かけてddresucueしましたが、NASのパーティションはマウントできず`fsck.hfsplus`を実行しても修復出来ない有り様でした。つまり失敗です。


## photorecでファイルを救出する
[TestDisk](http://www.cgsecurity.org/wiki/TestDisk)でHDDをクイックスキャンしてみるとパーティションは正しく認識できています。じゃあなんとかならんもんかと[PhotoRec](http://www.cgsecurity.org/wiki/PhotoRec)を試してみました。

```bash
sudo apt-get install testdisk # photorecはtestdiskに付随します
photorec
```

あとはメニューにしたがってリカバリしたいパーティションの選択、リカバリしたいファイルの拡張子の指定、保存先を選択して実行です。なんと、もりもりファイルを復元してくれる！

## 9時間後
Photorecの処理が終わったので、リカバリされたファイルをざっと見てみると相当な数のファイルが(1TBぐらい)復元されましたが、不完全なものが多数あり救出したとはいいがたい状況でした。またファイル数が多すぎて必要／不要なファイルの仕分けにもかなり時間がかかりそうでした。

## 結果
結局は新しく購入したHDDをTime Capsuleに入れフォーマットし、一から出直すことになりました。これからCDのリッピング地獄が待っています。

あと、バックアップは2重の構えで。

## 余談 HDDのないTime Capsule
HDDの入っていないTime Capsuleですが、ルータとしては問題なく使えます。ただ、「内蔵ディスクを修復する必要があります」という警告とオレンジ色のランプは点灯しています。

## 参考
* [Time Capsule：びぼうろぐ：So-netブログ](http://bibo-log.blog.so-net.ne.jp/archive/c2301125764-1)
* [故障したTime Capsuleからデータを救い出す方法：びぼうろぐ：So-netブログ](http://bibo-log.blog.so-net.ne.jp/2010-03-08)
* [ddrescue](https://ja.wikipedia.org/wiki/Ddrescue)
* [Ddrescue - Forensics Wiki](http://www.forensicswiki.org/wiki/Ddrescue)
* [DataRecovery - Community Ubuntu Documentation](https://help.ubuntu.com/community/DataRecovery)
* [File Recovery - ArchWiki](https://wiki.archlinux.org/index.php/File_Recovery)
* [UNetbootin](http://unetbootin.sourceforge.net/)
* [TestDisk](http://www.cgsecurity.org/wiki/TestDisk)
* [PhotoRec](http://www.cgsecurity.org/wiki/PhotoRec)
