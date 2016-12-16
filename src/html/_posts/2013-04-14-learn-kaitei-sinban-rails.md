---
layout: post
title: 改訂新版RubyonRailsを進めている
categories: ruby
---
rails 3.2.13でエラーが出ては解決して進めている。chapter 8で躓いていた。Rake db:resetでエラーが出る。プロパティが存在しないよというエラーだった。

解決方法は、

* DBのSchemeで定義されていないプロパティ(password等)はattr_accessorで定義しなければいけない（当たり前か）

他に進める上で注意しなければいけないのは、

* 更新したいカラムはattr_accessibleで定義しなければいけない。

もしくは、

* [Rails 3.2.3ではwhitelist_attributesの設定が必要](http://www.oiax.jp/rails3book/rails323_whitelist_attributes)

開発環境はMacでエディターはvim。最近[Nerd tree](https://github.com/scrooloose/nerdtree)を導入したので、textmateぽく右にエクスプローラーがでている。そして、[vim-rails](https://github.com/tpope/vim-rails)。これ便利だと様々なblogで見かけたけど、実際にrailsで何かしようと思うと便利。ファイルの行き来だけではなく、rails、Rakeコマンドも実行できる。

あと、web serverは[pow](http://pow.cx/)を使っている。それと、[powder](https://github.com/Rodreegez/powder)。

こういう開発環境は手を動かさないと身につかないな。
