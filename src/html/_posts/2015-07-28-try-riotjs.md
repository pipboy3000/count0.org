---
layout: post
title: Riot.js試してみた
categories: js
---
React likeでミニマムな[Riot.js][riotjs]がどんなもんか試してみました。[DEMO][auc_cat](Herokuがよく寝ているので初回レスポンスがすごく遅いです)

[ヤフオクのカテゴリ一覧がCSV][auction_csv]で公開されていてこれが1.3MBほど。localStorageに全部入るぞ。これでサクサク検索してオークションIDがわかれば作業効率よくなるかもという会話をバイト先でしていて、じゃあRiot.js試すついでにという経緯で作りました。結局localStorage使っていないけど、それで満足している。

構成は`search.tag`と`list.tag`と`message.tag`があって、`search.tag`で検索キーワードを入力してAPIに投げる。返って来たJSONを`list.tag`に流し込んで一覧表示する。`message.tag`は打ち込んだキーワードやJSONに反応してメッセージを表示するだけ。

最初は`app.tag`を作ってそこに全部ぶち込んでいたけど、それって再利用可能なWebコンポーネント的じゃないなと思って分割。再利用可能かはかわからない。でもタグ間の連携を考慮して設計することでDispatcher必要だなとか、Flux的なものが必要になってくるなという実感がわいた。独自タグを記述せずに既存のDOMを使える点、`id`や`name`属性を設定しておけば簡単にアクセスできる点は気が利いている。`style`はscopeが便利な反面、ちゃんとコンポーネントとしてスタイルを作り込むならscss等使いたいよなと思った。

雑感としては、ドキュメントみればすぐに使えるし、ファイルサイズも小さいので[GAMYの事例][example_gamy]のように普通のWebサイト[^whatwebsite]に組み込んで使うのに良い。お手軽感がある。jQuery + Mustache(及び類似テンプレート)でJSONデータを表示するような用途の代替案でもいいなと思う。SEO気にするなら[Server-side Rendering][serverside_rendering]もあるけど、Node.jsのサーバー用意する必要があって普通のWebサイトで使う分にはお手軽感が減る。

ビルドツールはgulpとBrowserifyで[gulpfileはこんな感じ][gulpfile]。gulpfile書いたり評価している時間がだんだん長くなってきている。最近[budo][budo]を覚えたので、気軽に試したい場合はそっちを使おうと思っている。

[^whatwebsite]: LAMP環境でWordpressを使っているようなWebサイト。

[riotjs]:           https://muut.com/riotjs/
[auction_csv]:      http://batchsubmit.auctions.yahoo.co.jp/show/batch_categorymap
[auc_cat]:          http://pipboy3000.github.io/auc-cat/
[example_gamy]: http://qiita.com/narikei/items/1a7fbd7895cfb4220172
[serverside_rendering]: https://muut.com/riotjs/guide/#server-side
[gulpfile]: https://github.com/pipboy3000/auc-cat/blob/master/gulpfile.js
[budo]: https://github.com/mattdesl/budo
