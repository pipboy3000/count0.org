---
layout: post
title: CSSのフレームワークは極力導入すべき 
categories: css
---
2人以上でCSSを書く場合は<a href="http://sass-lang.com/">Sass</a>は当たり前として、<a href="http://git-scm.com/">Git</a>で共有し、CSSフレームワークを導入すべき。

あるプロジェクトで突発的に多人数でCSSを書くことがあった。

状況は悪くて、実装すべきデザインがすべて完成していない上で、各ページのHTMLとCSSを多人数で実装するというスタート。

幸いSass(scss)を導入していたので、CSSの記述スピードに関しては問題ないのだが、CSSルールに各個人の個性が出てくる。

こまめにコミュニケーションをとり、使い回し出来るパーツはGitで共有する。デザインのHTML、CSS実装を進めながらチグハグCSSフレームワークが出来ていく。チグハグゆえに完成度もチグハグするだろう。

学習コストとスケジュールを考えると怖かったから出来なかったが、最初からCSSフレームワークを導入しておけばよかったと後悔している。基本を抑えている<a href="http://compass-style.org/">Compass</a>でも導入しておけば、各個人のCSSルールに統一感で出ただろうと、チグハグCSSフレームワークをまとめる立場から思うのであった。 