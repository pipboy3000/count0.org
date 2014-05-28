---
layout: post
title: Steam OSをインストールしてみた
categories: linux
---
[はじめての自作PC][1]のきっかけとなった壊れたXPS8100にSteam OSをインストールしてみました。

まず故障したHDDを<a href="http://www.amazon.co.jp/gp/product/B009QWUF9E/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B009QWUF9E&linkCode=as2&tag=count_0-22">安いHDD</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B009QWUF9E" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />に取り替えました。次に地味なところなのですが、テレビとHDMI接続する際にグラボ側には<a href="http://www.amazon.co.jp/gp/product/B00GZIHSNI/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00GZIHSNI&linkCode=as2&tag=count_0-22">HDMIの変換コネクタ</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B00GZIHSNI" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />が必要だったりします。後述しますが、ゲームのコントローラーがあると助かります。使いすぎても安心の耐久性を誇る<a href="http://www.amazon.co.jp/gp/product/B004R1R9IO/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B004R1R9IO&linkCode=as2&tag=count_0-22">XBOXのコントローラー</a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=count_0-22&l=as2&o=9&a=B004R1R9IO" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />がオススメです。

[Build your own Steam Machine][2]に書かれている必須スペックは

* IntelかAMDの64bitプロセッサ
* 4GB以上のメモリ
* 500GB以上のHDD
* NVIDIAのグラボ(AMDとIntelのサポートはもうすぐさ！)
* UEFIブートできるマザボ
* USBスティックを使ってインストールするのでUSBポート

問題なしと思いきや、XPS8100はUEFIをサポートしていませんでした。終わり。

が、終わりません。Valveは[UEFIをサポートしていないシステム向けのISO][3]をリリースしていました。すばらしい。ISOを[Win32 Disk Imager][3]を使ってUSBスティックに書き込めばインストールメディアの出来上がりです。

あとはUSBスティックをPCに差し、PC起動時にF12連打でブートメニューを呼び出し、USBスティックから起動します。Windowsとデュアルブートすることもないので、`Automatic Install`でHDDの中身を全部消しシステムをインストールします。

インストール後、Gnomeが立ち上がりSteamへのログインを求められます。その後再起動を経て今度はSteamの[Big Pictureモード][5]が立ち上がります。

![Daisywheel](/images/steamos1.jpg)
初期設定が始まり、再度Steamにログインするように情報を求められますが、キーボードは英語配列なんですね。コントローラーを使ってDaisywheel入力です。

![システム情報](/images/steamos2.jpg)
素のXPS8100ではなくて、電源とメモリは交換してあったりする。

![Linux対応のゲーム一覧](/images/steamos3.jpg)
Linux対応のゲームがずらり。EU4も対応しているとは驚き。

---

使わなくなったPCをゲーム機([Steam Machine][6])にできればと思いSteam OSをインストールしてみましたが、なんとも巨大なゲーム機の出来上がりです。

リビングに置いても違和感のない大きさのSteam Machineで親機からゲームストリーミングができればかなりいいなと思いました。

---
追記

2014年5月22日にゲームストリーミングができるようになりました。

また、キーボードレイアウトが英語配列になっている問題はSteam OSの設定でLinuxデスクトップを有効にし、Gnomeの設定でキーボードレイアウトをJapaneseにすればOKでした。

他にはHDMIで音声が出力できない問題もあるのですが、GithubのIssueを見てもなかなか解決できません。

[1]: /2014/03/26/DIY-pc.html
[2]: http://store.steampowered.com/steamos/buildyourown?l=japanese
[3]: http://steamcommunity.com/groups/steamuniverse/discussions/1/648817378243644036/
[4]: http://sourceforge.net/projects/win32diskimager/
[5]: http://store.steampowered.com/bigpicture/?l=japanese
[6]: http://store.steampowered.com/livingroom/SteamMachines/?l=japanese
