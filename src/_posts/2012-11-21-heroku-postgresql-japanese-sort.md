---
layout: post
title: HerokuのPostgresqlで日本語ソートにハマった
categories: ruby
---
日本語のカラムをソートすると順番がおかしい。

StackOverflowを漁り遠回りしつつ、最終的に[リンク先](http://qa.atmarkit.co.jp/q/2205)に書いてある通りCOLLATEを指定すると良い。

ActiveRecordを使っていたので、Production環境ではCOLLATEを明示的に書くことでこの問題を回避できた。

``` ruby
class Hoge < ActiveRecord::Base
  default_scope order('name COLLATE "C" ASC') if ENV["RACK_ENV"] == "production"
end
```
