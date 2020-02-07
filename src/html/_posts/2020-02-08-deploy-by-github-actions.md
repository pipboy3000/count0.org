---
layout: post
title: GitHub Actionsでブログをデプロイする
categories: misc
---

このブログはJekyllで作られ、S3にファイルを置き、CloudFrontで配信するという構成になっている。

手元でファイルをビルドして[s3_website](https://github.com/laurilehmijoki/s3_website)を使ってS3、CloudFrontへデプロイしていたのだが、このs3_websiteの調子がよろしくないので、デプロイで失敗するようになった。また、s3_websiteはメンテナー不在でこの先不安なので、どうにかしなきゃという状態だった。

月に1回記事を作ればいいほうなので、毎回手動でデプロイしてもよいのだが、GitHub Actionsを試してみたら、成功した。自動化だ。

```yaml
{% raw %}
name: Deploy

on:
  push:
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: setup Ruby
      uses: actions/setup-ruby@v1.0.0
    - name: setup Node.js
      uses: actions/setup-node@v1.1.0
    - name: build
      run: |
        npm i
        bundle install
        npm run publish
    - name: sync s3
      uses: jakejarvis/s3-sync-action@master
      with:
        args: --exclude '.git*/*' --delete --follow-symlinks
      env:
        SOURCE_DIR: 'dist'
        AWS_REGION: 'ap-northeast-1'
        AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    - name: invalidate
      uses: chetan/invalidate-cloudfront-action@v1.2
      env:
        DISTRIBUTION: ${{ secrets.DISTRIBUTION }}
        PATHS: '/*'
        AWS_REGION: 'ap-northeast-1'
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
{% endraw %}
```

手順は`master`ブランチに更新があれば

* RubyとNode.jsをセットアップ
* node modulesとgemをインストール
* npm scriptを実行してビルド、
* S3にビルドしたファイルをアップロード
* CloudFrontの更新を実行する

このブログ、HTMLはjekyllでビルドしているが、CSSやJavaScriptはwebpackでビルドしているので、このような感じになった。

実行時間は5分程度。node module、gemのインストールとビルドに時間がかかっている。テストを実行しているわけでもないし、気付いたらデプロイ完了していればいいので、キャッシュなどはとりあえずいいかといったところ。