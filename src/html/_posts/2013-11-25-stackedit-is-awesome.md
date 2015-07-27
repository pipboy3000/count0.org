---
layout: post
title: StackEditが素晴らしい
categories: service
---
Chromeウェブストアで見つけた[StackEdit](https://stackedit.io/)が素晴らしいです。これでMarkdownPad2やMarkedを捨てることができます。

下の機能が使えるのでこれから大活躍しそうです。

## PDFエクスポート
資料配布の時はPDFのほうがなにかと都合がいいので、必須機能です。今までhtmlに出力してPDFに印刷していました。グッバイ、無駄な作業。

## Fenced code block
コードを記述するときFenced code blockを使っているので、あると嬉しいです。

## Code Syntax highlight
資料の中にコードの説明が必要なときに必須です。これがないと読みづらい。

## Markdown Extra
変数の一覧など表形式で説明したいものがある場合、資料がすっきりわかりやすくなります。

## サービス連携
作成した文章はブラウザのlocal strageに保存されるようですが、以下のサービスと連携できます。

文章単位のシンクロ

* Google Drive
* Dropbox

公開

* blogger
* Dropbox
* Gist
* Github
* Google Drive
* SSH server
* Tumblr
* Wordpress

## アイコン
地味に役立ちそうなのが、デフォルトで用意されているテーマのcssに定義されているアイコン。アイコンを使うには生のhtmlを書かなければいけませんが、ちょっとしたアクセントに使えます。web fontをfontelloで生成しているようですが、[ラインセンス一覧のものが](https://stackedit.io/res/libs/fontello/LICENSE.txt)使えるのかな？

## YAML Front Matter
`Settings`の`Service`にある`Default template`と`PDF template`のハテナをクリックすると使える変数の一つにYAML Front Matterがありました。あと[templateはunderscore.js](http://underscorejs.org/#template)のようです。

使う場合は、`frontMatter`オブジェクト経由でアクセスします。

Markdownの本文

```yaml
---
update: 2013/11/25
project: count0.org
---

# hogehoge
本文

```

テンプレート

``` html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><%= documentTitle %></title>
<link rel="stylesheet" href="https://stackedit.io/res-min/themes/default.css" />
<script type="text/javascript" src="https://stackedit.io/libs/MathJax/MathJax.js?config=TeX-AMS_HTML"></script>
</head>
<body>
<div class="container">
<p><%= frontMatter.project %></p>
<p><%= frontMatter.update %></p>
<%= documentHTML %>
</div>
</body>
</html>
```

他に独自拡張を使える、テーマを作成できるなど良いところばかりで突然有料になってしまわないか不安になる程の素晴らしさです。しばらくはこれで。
