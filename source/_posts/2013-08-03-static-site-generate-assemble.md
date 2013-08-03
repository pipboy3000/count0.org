---
layout: post
title: assembleで静的webサイトを作った
categories: js
---
お仕事でデザイナーさんの作ったデザインを元にhtml, css, js, 画像など静的なwebサイトを作って、システム屋さんに渡すということが多々あります。数ページで構成されたものならいいとして、複数デバイス、数十ページになるとさすがになんらかのテンプレートシステムの導入を考えます。最近のお仕事で[assemble](https://github.com/assemble/assemble)というnode.jsベースかつgruntで回せる静的webサイトジェネレータを使いました。

## assembleで何ができるか

githubのプロジェクトページにこう書かれています。

>  A Grunt.js plugin for building sites, documentation and components from reusable templates and data. Includes options for using JSON, YAML, YAML front matter, Handlebars templates, pages, partials, layouts, helpers...

案件的にはサーバがなくてもssiやphpのincludeができて条件分岐も使えてhtmlに出力できたらいいな。程度だったので、gruntで回せてpartialもlayoutもYAML front matterも使えることは大変役にたちました。

## Handlebars
このテンプレートのことは知らなかったけど、mustache系なんだなという印象。helpersは全く使いませんでした。

## 変数
YAML front matterで変数定義できて便利です。[このページ](http://assemble.io/docs/YAML-front-matter.html)に書かれているようにページ固有のデータを定義しておいて、テンプレートで使う。例えばpageに変数定義して、layoutで変数の値で読み込むpartialを切り替えるようにしておくと便利。

{% gist 6140184 %}

その他に[jsonファイルに変数を定義する。YAMLファイルに定義する。gruntfileに定義できて、大変柔軟に使える](http://assemble.io/docs/Data.html)けど、自分が使ったのはYAML front matterのみです。

## それで
時系列ではこのブログを作るより前にお仕事でassembleを使いました。今だったらjekyllを使ったかもしれませんし、middlemanを使ったかもしれません。assembleの利点はgruntで回せること。会社で使うwindows xpではgruntのほうがguardよりも安定して動くからです。
