---
layout: post
title: Let's EncryptでS3静的ウェブサイトホスティングのブログをHTTPS化
categories: service
---
![証明書](/images/lets-encrypt-lets-https-browser.png)

従来通りHTTPでもアクセスできます。無償で利用可能なSSL証明書の発行サービスLet's Encryptがパブリックベータになったので、count0.orgの証明書の発行とブログをHTTPS化してみました。結論から言うと証明書の発行は簡単。ブログのHTTPS化は面倒でした。

## Let's Encryptとは
Let's Encryptについては[こちら][letsencrypt-overview]や[こちらの説明][what-letsencrypt]を一読することをオススメします。

## 証明書を手に入れる
Let's Encryptのクライアントソフトをダウンロードします。OSXのサポート状況はvery experimentalらしいので覚悟を決めてコマンドを実行します。
homebrewが依存関係を解決してクライアントソフトをインストールしてくれます。その後対話形式の画面が立ち上がってそれに従って進む感じです。

```bash
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrupt

# 実行
./letsencrypt-auto certonly --manual --email shakeforme@gmail.com -d count0.org
```

途中ドメイン所有者か確認するためにS3のバケットに`.wll-known/acme-challenge/適当なファイル名`という中身が適当な文字列なファイルを置いて、確認が取れたら`/etc/letsencrypt/live/count0.org/`以下に証明書が作られました。ゲットだぜ！

```bash
$ sudo tree /etc/letsencrypt/live/count0.org
/etc/letsencrypt/live/count0.org
├── cert.pem -> ../../archive/count0.org/cert1.pem
├── chain.pem -> ../../archive/count0.org/chain1.pem
├── fullchain.pem -> ../../archive/count0.org/fullchain1.pem
└── privkey.pem -> ../../archive/count0.org/privkey1.pem
```

インストールから証明書の入手までは[クラスメソッドさんの記事][letsencrypt-classmethod]を参考にしました。

## ブログをHTTPS化する
証明書を手に入れたのでcount0.orgをHTTPS化します。このブログはS3を使っています。しかし、独自ドメインで静的ウェブサイトホスティングをしている場合、SSLはサポートされないみたいです([REST APIエンドポイントとウェブサイトエンドポイントの表を参照][websiteendpoint])それでどうするか。Cloudfrontを使えば独自ドメインでSSLを使えるとのこと。

今までの構成

インターネット > Route53 > S3のバケット

これからの構成

インターネット > Route53 > Cloudfront > S3のバケット

正直なところ大してアクセスのないこのブログにCDNを使うのは気が引けますが、こうしなきゃHTTPSにできないのでやってみます。

## IAMに証明書をアップする
Cloudfrontで独自ドメインのSSLを利用する場合、IAMに証明書を登録しておく必要があります。マネジメントコンソールでは登録できないのでaws-cliを使い登録します。
`count0.org-ssl`という名前で登録しました。

```bash
sudo aws iam upload-server-certificate --server-certificate-name count0.org-ssl \
--certificate-body file:///etc/letsencrypt/live/count0.org/cert.pem \
--private-key file:///etc/letsencrypt/live/count0.org/privkey.pem \
--certificate-chain file:///etc/letsencrypt/live/count0.org/chain.pem \
--path /cloudfront/blog/
```

## Cloudfrontを設定する
マネジメントコンソールのCloudfrontに移動して`Create Destribution`ボタンをクリックし、Webの`Get Started`ボタンから作成画面に進みます。

下記項目以外はデフォルトのままで作成しました。

* `Origin Domain Name`

  入力候補にS3のREST APIエンドポイントが表示されますが、ウェブサイトエンドポイントを入力します。これの意味ですが、サブディレクトリにおける`Default Root Object`の挙動に関係します。REST APIエンドポイントを指定した場合、サブディレクトリに対して`Defalt Root Object`が効かないのです。

  S3のREST APIエンドポイントを指定した場合

  |パス|アクセス|
  |:--|:--|
  |/|OK|
  |/index.html|OK|
  |/archives/index.html|OK|
  |/archives/|NG|

  S3のウェブサイトエンドポイントを指定した場合

  |パス|アクセス|
  |:--|:--|
  |/|OK|
  |/index.html|OK|
  |/archives/index.html|OK|
  |/archives/|OK|

  ウェブサイトエンドポイントのURLはS3のバケットのプロパティ、静的ウェブサイトホスティングから確認できます。

  [![S3のウェブサイトエンドポイント](/images/lets-encrypt-lets-https-websiteendpoint.png)](/images/lets-encrypt-lets-https-websiteendpoint.png)

* `Origin ID`

  適当な名前でいいのですが、今回は`S3-count0.org`と入力しました。

* `Alternate Domain Names(CNAMEs)`

  独自ドメインでCloudfrontを使うので、ブログのドメインを指定します。`count0.org`

* `SSL Certificate`

  IAMにSSLを登録していれば`Custom SSL Certificate (stored in AWS IAM)`に選択肢が表示されるので、それを選択します。
  選択すると`Custom SSL Client Support`が現れるので、`Only Clients that Support Server Name Indication (SNI)`を選択します。
  `All clients`を選択した場合は月$600かかります。詳しくは[ドキュメントを参照][cloudfront-custom-domain-ssl]。またSNIをサポートしているブラウザは[Wikipediaの記事][wikipedia-sni]を参照してください。Android 2系、Phantom JS 1系はサポートされませんが、それはまあいいです。

* `Default Root Object`

  前述のように`Origin Domain Name`の指定で挙動が変化します。平たく言うとDirectory Indexです。`index.html`にします。

作成完了後、配信準備に入ります。statusが`In Progress`から`Deployed`になれば配信準備完了です。

## Route53を設定する

Route53でAレコードの`Alias Target`を作成したCloudfrontのDomain Name(xxxxxxxx.cloudfront.net)に変更します。

## s3_website

ブログをS3にデプロイするのに使っている[s3_website][s3_website]の設定を編集します。`s3_website.yml`に`cloudfront_distribution_id`を追記しました。値は作成したCloudfrontのdestributionのID。それに加えブログ更新に使っているIAMのグループに対してCloudfrontFullAccessのポリシーを追加しました。これでブログを更新したらCloudfrontも更新されるようになります。

## 今後

祝HTTPS化です。副作用でCDN配信も実現してしまいました。そして個人では学習する機会がなかったであろうCloudfrontを体験できました。

今後の課題は2016年3月に切れる証明書を自動更新する仕組みを作らなければいけないことです。きっとaws-cliを使うことになるでしょう。その役目は家でリモートスピーカーになっているRaspberry Piにお願いしようと思っています。

[letsencrypt-overview]: https://bifurcation.github.io/letsencrypt-overview/index-jp.html#/
[letsencrypt-classmethod]: http://dev.classmethod.jp/server-side/lets-encrypt-beta/
[what-letsencrypt]: http://jxck.hatenablog.com/entry/letsencrypt-acme
[websiteendpoint]: https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/WebsiteEndpoints.html
[cloudfront-custom-domain-ssl]: http://aws.amazon.com/jp/cloudfront/custom-ssl-domains/
[wikipedia-sni]: https://ja.wikipedia.org/wiki/Server_Name_Indication
[s3_website]: https://github.com/laurilehmijoki/s3_website
