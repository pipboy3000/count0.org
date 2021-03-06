---
layout: post
title: assembleで静的webサイトを作った
categories: js
---
お仕事でデザイナーさんの作ったデザインを元にHTML, CSS, JS, 画像など静的なwebサイトを作って、システム屋さんに渡すということが多々あります。数ページで構成されたものならいいとして、複数デバイス、数十ページになるとさすがになんらかのテンプレートシステムの導入を考えます。最近のお仕事で[assemble](https://github.com/assemble/assemble)というNode.jsベースかつGruntで回せる静的Webサイトジェネレータを使いました。

## assembleで何ができるか

githubのプロジェクトページにこう書かれています。

>  A Grunt.js plugin for building sites, documentation and components from reusable templates and data. Includes options for using JSON, YAML, YAML front matter, Handlebars templates, pages, partials, layouts, helpers...

案件的にはサーバがなくてもSSIやPHPのincludeができて条件分岐が使えてHTMLに出力できたらいいな。程度だったので、Gruntで回せてpartial、layout、YAML front matterが使えることは大変役にたちました。

## 2013/10/30追記

ものすごく簡単な[サンプル](https://github.com/pipboy3000/assemble-example)を作りました。テンプレートファイルを監視してHTMLを生成します。OS X 10.9の人はgrunt-contrib-watchを動かすためにNode.js v0.10.21以上が必要です。

## Handlebars
このテンプレートのことは知らなかったけど、Mustache系なんだなという印象。helpersは全く使いませんでした。主にif, eachを使いまくってます。

## 変数
YAML front matterで変数定義できて便利です。[このページ](http://assemble.io/docs/YAML-front-matter.html)に書かれているようにページ固有のデータを定義しておいて、テンプレートで使う。例えばpageに変数定義して、layoutで変数の値で読み込むpartialを切り替えるようにしておくと便利。

<script src="https://gist.github.com/pipboy3000/6140184.js"></script>

その他に[jsonファイルへ変数を定義する。YAMLファイルに定義する。gruntfileに定義できて、大変柔軟に使える](http://assemble.io/docs/Data.html)けど、自分が使ったのはYAML front matterのみです。

## それで
時系列ではこのブログを作るより前にお仕事でAssembleを使いました。今だったらJekyllを使ったかもしれませんし、Middlemanを使ったかもしれません。Assembleの利点はGruntで回せること。会社で使うWindows XPはGruntのほうがGuardよりも安定して動くからです。

## その後
職場の環境(Windows XP)ではJekyll、Middlemanが動かないのでAssemble使っています。

## 参考
* [assemble/assemble](https://github.com/assemble/assemble)
* [Assembleのドキュメント](http://assemble.io/docs/)
* [ものすごく簡素なサンプル](https://github.com/pipboy3000/assemble-example)



