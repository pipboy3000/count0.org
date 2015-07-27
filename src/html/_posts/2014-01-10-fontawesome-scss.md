---
layout: post
title: Font Awesomeのscssを使った
categories: scss
---
このブログではSymbolsetの[Social Regular](https://symbolset.com/icons/social-regular)というアイコンを使っていました。このアイコンはオープンソースではないので、このブログのgithubリポジトリには含めることが出来ませんでした。なにか歯抜けのような気分だったので、他のアイコンに乗り換えようとおもいつつも月日が過ぎて行きました。

## Font Awesome
Font Awesomeというとlessで作られている、Bootstrapで使うものという印象が強かったのですが、最近のバージョンではlessだけではなくscss版も提供されているので、こいつを使おうと思いました。

## font-awesome-sassがあるじゃないか。
[Get Started](http://fontawesome.io/get-started/)のページに書かれていますが、`font-awesome-sass`というgemがあります。これを使えばいいじゃないかと思うのですが、残念ながらrailsで利用されることを前提にしている模様。non railsな環境では使いにくいです。

## 自分の環境に組み込む
結局zipファイルをダウンロードして、このブログのscssに組み込みました。ディレクトリレイアウトは以下の通りで[The Sass WayのHow to structure a Sass project](http://thesassway.com/beginner/how-to-structure-a-sass-project)を参考にしています。最近のマイブームなディレクトリレイアウトです。

jekyllで`src/_assets/scss/style.scss`が`_site/css/style.css`に出力され、`src/fonts`は`_site/fonts`に出力されるようにしています。`_site`はウェブルートになるディレクトリです。

```
src
├── _assets
│   └── scss
│       ├── modules
│       ├── partials
│       ├── style.scss
│       └── vendor
│           ├── _font-awesome.scss
│           └── font-awesome
│               ├── _bordered-pulled.scss
│               ├── _core.scss
│               ├── _fixed-width.scss
│               ├── _icons.scss
│               ├── _larger.scss
│               ├── _list.scss
│               ├── _mixins.scss
│               ├── _path.scss
│               ├── _rotated-flipped.scss
│               ├── _spinning.scss
│               ├── _stacked.scss
│               └── _variables.scss
└── fonts
    ├── FontAwesome.otf
    ├── fontawesome-webfont.eot
    ├── fontawesome-webfont.svg
    ├── fontawesome-webfont.ttf
    └── fontawesome-webfont.woff
 ```

`_font-awesome.scss`の中身をディレクトリレイアウトに合わせて書き換えています。

``` scss
@import "vendor/font-awesome/variables";
@import "vendor/font-awesome/mixins";
@import "vendor/font-awesome/path";
@import "vendor/font-awesome/core";
@import "vendor/font-awesome/larger";
@import "vendor/font-awesome/fixed-width";
@import "vendor/font-awesome/list";
@import "vendor/font-awesome/bordered-pulled";
@import "vendor/font-awesome/spinning";
@import "vendor/font-awesome/rotated-flipped";
@import "vendor/font-awesome/stacked";
@import "vendor/font-awesome/icons";
```

`style.scss`で`_font-awesome.scss`を読み込んでいます。

``` scss
@charset "utf-8";

@import "partials/base";

@import "partials/elements";
@import "partials/page";
@import "partials/article";
@import "partials/category";
@import "partials/pagination";
@import "partials/responsive";

@import "vendor/syntaxhighlight";
@import "vendor/font-awesome";
```

これでアイコンが使えます<i class="fa fa-thumbs-o-up"></i>(markdown文章に生なhtmlを書くのは抵抗ありますが・・・)
