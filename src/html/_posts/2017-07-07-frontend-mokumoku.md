---
layout: post
title: 'フロントエンドもくもく会#05でもくもくしてきた'
categories: js
---
HTML5NAGOYAのフロントエンドもくもく会 #5に参加してきた。これは会場に集まって黙々と自分の設定した課題にチャレンジするというものである。

自分はというとTwitterのタイムラインで名前を知りGithubのREADMEを読んだ程度であった[HyperApp](https://github.com/hyperapp/hyperapp)を試してみようと思った。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">HyperApp試してみるかも <a href="https://t.co/3LiPe5vGkA">https://t.co/3LiPe5vGkA</a></p>&mdash; アサイマサミ (@count0) <a href="https://twitter.com/count0/status/872998225627631617">2017年6月9日</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

が、何かを作ったわけではない。作る前の段階でアイデアを試していた。それはわずか1KBであるHyperAppの軽さに注目して、ビルドツールなしでJSXを書いてアプリを作れないだろうかというアイデア。jQuery感覚で読み込んだら即使えるというのは、特に小規模なWebサイトであれば役に立ちそう。

それで試行錯誤していると[babel-standalone](https://github.com/babel/babel-standalone)に行き着いた。これはBabelのWebサイトにあるREPL、JSFiddle、JS Bin、Codepenのようなサービスで使うことを想定されているようだ。全くの盲点。まさかBabelをブラウザで動かすなんて。考えたこともなかった。

これでビルドツールいらず、JSXでコードが書ける。例えば以下のように。

``` html
<!doctype html>
<html lang="ja">
<head>
  <title>HyperApp Sample</title>
  <meta charset="UTF-8">
</head>
<body>
  <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
  <script src='https://unpkg.com/hyperapp'></script>
  <script type='text/babel'>
    const { h, app } = hyperapp
    /** @jsx h */

    app({
      state: 0,
      view: (state, actions) => (
      <main>
        <h1>{state}</h1>
        <button onclick={actions.add}>+</button>
        <button onclick={actions.sub}>-</button>
      </main>
      ),
      actions: {
        add: state => state + 1,
        sub: state => state - 1
      }
    })
  </script>
</body>
</html>
```

大成功！ではなくオチがある。

[babel-standaloneはコード圧縮かつgzip圧縮](https://unpkg.com/babel-standalone@6.25.0/babel.min.js)して212KBある。HyperApp、1KBのアドバテージを消し去る重さだ。ちなみにみんなの「いとしいしと」[jQueryをunpkg.comでダウンロード](https://unpkg.com/jquery@3.2.1/dist/jquery.min.js)したら29.6KB。こちらもコード圧縮かつgzip圧縮。その巨大さがよくわかるだろう。

サクッと使うには躊躇するデカさ。思うようにはいかないものである。

今回のもくもく会のように時間に上限があり、ビルドツールの設定に時間をかけるのではなく、迅速にコードを書き始めたい場合はいいかもしれない。しかし、先述したJSFiddleのようなオンラインのプレイグラウンドを使った方が賢いと思う。

そしてこの結果を会の最後に発表したら参加者でbabel-standaloneが参考になった人がいたので、最終的にはめでたしめでたしである。