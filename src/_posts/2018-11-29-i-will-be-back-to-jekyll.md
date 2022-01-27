---
layout: post
title: ブログエンジンを乗り換えようと思って
categories: misc
---

先日、ATEAMが主催するイベントに参加して、このJekyllで作られているブログをどうにかしてやろうと思った。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日のイベント、WordpressからNuxt.jsに移行する話が面白かったので、俺もJekyllからNuxt.jsに移行してみようかしら。URLを維持できるかが手間かな。</p>&mdash; アサイマサミ (@count0) <a href="https://twitter.com/count0/status/1062718312872763393?ref_src=twsrc%5Etfw">November 14, 2018</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

懸念はURL、パーマリンクを維持できるか。理想は原稿のmarkdownがそのまま使えること。

具体的には原稿であるYYYY-mm-dd-title.mdが/YYYY/mm/dd/title.htmlになればよい。

Nuxt.jsで作る場合は自前でパーマリンク含めいろいろと独自実装する必要がある。それもいいのだが、静的サイトジェネレーターのVuePressが気になったので調べた。

公式プラグインのblogを使えば現状に近いパーマリンクを実現できそう。コードをフォークして調整すればなんとかなりそうだ。その他にHexoも検討してドキュメントを読んだ。こちらは設定だけで現状のパーマリンクをそのまま実現できそうだ。両者ともYAML front matterに対応している点もグッド。

便利なツールが次々に出現している。そしてどうなったかというとJekyllに戻った。

Jekyllの更新をほったらかしにしていたが、bundle updateで更新してビルドしたらちゃんと動いた。昔書いたアーカイブとカテゴリーページを生成する自前のプラグインもそのまま動いている。これでいいじゃないか。
