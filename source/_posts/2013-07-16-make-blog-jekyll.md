---
layout: post
title: jekyllでブログを作った
categories: jekyll
---
このブログは[jekyll](http://jekyllrb.com/)で作り、S3でホスティングしています。そのメモです。[github](https://github.com/pipboy3000/count0.org)でソースコードを公開しています。

## 動機
以前、tumblrで技術メモを書いていました。markdownも使えるので、良かったのですが、1つなんとかしたいところが。それはコードのシンタックスハイライト。fenced codeが使いたいがゆえにjekyllへの移行を決意しました。

## インストール
Gemfile作って

``` bash
bundle init
```

Gemfileに書いて

``` ruby
source "https://rubygems.org"

gem "jekyll"
gem "redcarpet"
gem "compass"
gem "s3_website"
gem "foreman"
```

インストール

``` bash
bundle install --path vendor/bundle
```

## _config.yml
fenced codeを使いたいので、redcarpetを使っています。  
urlは勝手にリンクがついて欲しいので`autolink`オプション、文中のアンダースコアを`em`に変換してほしくないオプションも付けました。  


``` yaml
source: source
timezone: Asia/Tokyo
permalink: /:year/:month/:day/:title.html
paginate: 10
exclude: ['']
markdown: redcarpet
redcarpet:
  extensions: ['autolink', 'no_intra_emphasis']
name: count0.org
analytics_id: UA-357228-7
author:
    name: Asai Masami
    email: shakeforme&#64;gmail.com
```

## ディレクトリレイアウト
bundlerやgruntでディレクトリが散らかってきたので、テンプレートやスタイル、記事などはsourceディレクトリに配置。

## 作る
htmlテンプレートは[html5bilderplate](http://html5boilerplate.com/)からファイルをダウンロードして、自分好みに。[liquid](http://liquidmarkup.org/)はsmartyやったことがあればだいたいわかるのとYAML Front Matterは便利だなという印象。  
スタイルシートはcompassの手を借りてシコシコ書く。デザインは凝ったものではないので、コードはあまり書いていません。とはいえ、デザイナーではないのでなかなか苦戦した部分でもあります。
あと仕事ではないのでレガシーブラウザは最初から考慮していません:(

開発環境は走りながら整えて行きました。 
最初はgruntとjekyllコマンドを別に動かしていて、まずjekyllコマンドをRakefileにまとめ、その次にforemanを使ってgruntとrakeコマンドを一緒に動かすようにしました。

gruntはcompass、jekyllが生成したファイルを監視してlivereloadをキックしています。また、プレビュー用にwebサーバを動かしています。ローカルでブログを書いている時、jekyllは`bundle exec jekyll build --watch --drafts`です。

最終的には

``` bash
bundle exec foreman start
```

でgruntとjekyllが走って良い感じです。ついでにいうと`foreman`はheroku toolbeltでインストールされていたので、

``` bash
foreman start
```

で動かしていたのに気づきました。  
localhost:9000をブラウザで開いておいて、chrome拡張のlivereloadをオン。これで記事のmarkdownやhtmlやjsやscssを編集するだけでプレビューが勝手に更新されるようになりました。快適。


## デプロイ
S3にデプロイしています。Gemfileに記述している[s3-website](https://github.com/laurilehmijoki/s3_website)がうまいことやってくれます。

``` bash
bundle exec s3_website cfg create # s3_website.ymlを生成してくれる。そこに設定を書き込む
bundle exec s3_website cfg apply # html配信できるようにバケット設定をしてくれる
bundle exec s3_website push # s3にファイルをアップロード
```

AWSのアクセスIDと秘密キーが必要になります。s3_website.ymlに直接書き込むとgithubで公開できないので、`~/.aws_settings`なんてファイルに

``` bash
export BLOG_AWS_ID=アクセスID
export BLOG_AWS_SECRET=秘密キー
export AWS_REGION=ap-northeast-1
```

と書いておいて`.bashrc`で以下のように読み込む。

``` bash
### AWS
if [ -f ~/.aws_settings ]; then
    source ~/.aws_settings
fi
```

こんな面倒くさいことをしているのは`.bashrc`もgithubに公開しているからです。

s3_website自体は簡単便利なものですが、S3とかIAMの方が最初わけがわからず難易度は高いです。このAWS特有の方言、ルールみたいなのは何か名前がついているのだろうか。

## jekyllで作ってみて
rssの出力、カテゴリー別記事一覧、コメント等普通のブログでは当たり前のように存在している機能が標準ではないので、つまづくところかもしれません。逆に欲しい機能は自分でなんとかする。という意気込みが必要というと敷居が高くなりますが、試行錯誤は必要かなと思います。面倒ならば、[octopress](http://octopress.org/)という選択肢もあるし、sinatraで自分ブログシステムを作るのも有りではないでしょうか。あ、wordpressもいいですね。

