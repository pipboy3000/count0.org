---
layout: post
title: 新しいMacbookを使って2ヶ月
categories: mac
---
届いて2ヶ月経ったMacbook。お仕事道具なので毎日使っているわけですが、至極快適です。

## Retina
以前は13inchのMacbook Airで今回は12inch。一回り小さい。が、Retinaになっているので以前より文字が見やすいくなりました。Kindleでゴルゴ読んでも小さい文字が見える。そして、Retina対応していないWebサイトの画像はすこぶる荒い。みんな[imgタグのsrcset属性][caniuse_srcset]を使おうぜ。

## US配列のキーボード
懸念だったキーボードのUS配列。最初はエンターキーの小ささ、スペースキーの大きさ、記号の位置に戸惑っていましたが、すぐに慣れました。日本語入力の切り替えは[Karabiner][karabiner]を使って右commandキーを英数/かなのトグルに割り当てることにしました。その他はOSXの設定でcaps lockをctrlキーにしたぐらい。

難点は:の入力。JIS配列では:を押せばよかったけど、US配列だとshift + ;で:になる。これはvimで厳しい感じだったので、.vimrcに以下を追記して対応しました。

```
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
```

キーストロークの浅さはあまり気にしていないどころか結構気に入っています。

## USB-C
Macbookの外部ポートはUSB-Cのみ、しかもそれは給電に使うのでUSB機器を使えないという心配があって、Ankerのハブを購入してみたものの、ほぼ使っていません。

<div class="amazon-block"><div class="image"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B019Z2Z4UY/count_0-22" target="_blank"><img src="http://ecx.images-amazon.com/images/I/41i7scEUgmL.jpg" /></a></div><div class="title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B019Z2Z4UY/count_0-22" target="_blank">Anker プレミアム USB-Cハブ HDMI &amp; Power Delivery 【高速USB 3.0 2ポート / HDMIポート / USB-C 充電ポート搭載】 USB Power Delivery対応 アルミニウム合金仕上げ フェルトポーチ付属</a></div><div class="label">Anker</div><div class="binding">エレクトロニクス</div><div class="rank">Sales Rank: 7374</div><a class="link" href="http://www.amazon.co.jp/exec/obidos/ASIN/B019Z2Z4UY/count_0-22">Amazonで詳細を見る</a></div>

それよりも、外出時はRaspberry Pi3の電源に使うつもりで持っていたAnkerのUSB急速充電器とUSB-Cのケーブルを持ち歩いています。これだとMacbookとiPhoneの充電に使えます。付属していた純正アダプターは家専用に使っています。これで電源アダプターを家に忘れることを恐れる必要がなくなりました。

<div class="amazon-block"><div class="image"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0156NEAJ2/count_0-22" target="_blank"><img src="http://ecx.images-amazon.com/images/I/312Ak7%2BW8vL.jpg" /></a></div><div class="title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0156NEAJ2/count_0-22" target="_blank">Anker 24W 2ポート USB急速充電器 iPhone 6s, 6s Plus/iPad Pro, Air, mini/iPod touch/Nexus/Xperia/GALAXY 他対応 【PowerIQ &amp; VoltageBoost 折畳式プラグ搭載】 (ホワイト) A2021121</a></div><div class="label">Anker</div><div class="binding">エレクトロニクス</div><div class="rank">Sales Rank: 7</div><a class="link" href="http://www.amazon.co.jp/exec/obidos/ASIN/B0156NEAJ2/count_0-22">Amazonで詳細を見る</a></div>

<div class="amazon-block"><div class="image"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0119RLTN4/count_0-22" target="_blank"><img src="http://ecx.images-amazon.com/images/I/31vyvqM-D9L.jpg" /></a></div><div class="title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0119RLTN4/count_0-22" target="_blank">Anker USB-C &amp; USB 3.0 ケーブル Type-C機器対応 1m</a></div><div class="label">Anker</div><div class="binding">エレクトロニクス</div><div class="rank">Sales Rank: 405</div><a class="link" href="http://www.amazon.co.jp/exec/obidos/ASIN/B0119RLTN4/count_0-22">Amazonで詳細を見る</a></div>


## 故障で入院
使い始めて一月が経つころにキーボードの「B」が陥没してしまい、キーの中央を押せば入力できるけど、隅の方は押しても反応しないという症状に悩まされたので、Apple Storeに持ち込みました。ジーニアスさんに見てもらって即修理工場行きが決まりました。予定は一週間。この間旧Macbook Airで仕事をすることになってしまいました。

US配列に慣れたら今度はJIS配列が苦手に。修理中にUS配列を忘れるのが嫌なのと、Macbook Airはキーボードがイかれてしまっていることもあり、AmazonでAnkerのUSキーボードを購入しました。すぐに届いたので、Karabinerで「外部キーボードがある場合、備え付けのキーボードは無効」という設定にしてキートップの上に外部キーボードを置くというフォーメーションで乗り切りました。

<div class="amazon-block"><div class="image"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B00U260UR0/count_0-22" target="_blank"><img src="http://ecx.images-amazon.com/images/I/41WTGFCs1lL.jpg" /></a></div><div class="title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B00U260UR0/count_0-22" target="_blank">Anker ウルトラスリム Bluetooth ワイヤレスキーボード iOS/Android/Mac/Windows に対応 ホワイト</a></div><div class="label">Anker</div><div class="binding">エレクトロニクス</div><div class="rank">Sales Rank: 579</div><a class="link" href="http://www.amazon.co.jp/exec/obidos/ASIN/B00U260UR0/count_0-22">Amazonで詳細を見る</a></div>

しかし、予想以上に早くMacbookが帰ってきた（金曜夜出発、火曜日帰宅）のでこのフォーメーションは数日で終わりました。

## ゲーム
期待はしてなかったけど、Paradoxの宇宙4Xストラテジーの「[Stellaris][stellaris]」とWWIIストラテジーの「[Hearts of Iron IV][hoi4]」を動かしてみました。両者ともグラフィックの質を落とせば、序盤は遊べるかなという感じです。ユニット数が増える中盤からはかなりもっさり。また、進行スピードを最高に設定しても遅いです。ゲームは素直にWindows機で遊んだほうがいいです。

[karabiner]: https://pqrs.org/osx/karabiner/index.html.ja
[caniuse_srcset]: http://caniuse.com/#feat=srcset
[stellaris]: http://www.stellarisgame.com
[hoi4]: https://www.paradoxplaza.com/hearts-of-iron-iv
