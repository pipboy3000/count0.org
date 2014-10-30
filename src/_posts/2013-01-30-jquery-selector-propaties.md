---
layout: post
title: jQueryのfindしたあとのselectorプロパティ
categories: js
---
jQueryのプラグインを書いていて壁にぶち当たった。  
jQueryでfindしたあとのjQueryオブジェクトのselectorプロパティが予想と違ってハマったのでメモ。

jQueryオブジェクトの`selector`プロパティをご存知であろうか。

``` javascript
	var $foo = $("#main li a");
	console.log($foo.selector);	// #main li a
```

selectorが取得できる。  
こんな感じで実行するようにプラグインを作った

``` javascript
	$.each(["#main", "#header", "#footer"], function(i, el) {
		$(el).find("li").somePlugin();
	});
```

プラグインの中で`selector`プロパティを参照すると"#main li a", "#header li a", "#footer li a"であると思っていたが全部"li a"になっていた。これは悲劇。  
どういうことか調べると、[stackoverflowのこのお話](http://stackoverflow.com/questions/12426622/why-does-the-selector-property-in-jquery-not-store-a-valid-selector-value)にたどり着く。  

プラグインの中でliveに使う用途向きだけど、jQueryのtraversing系メソッド通しちゃうと`selector`は意図しない感じになるようだ。

上記の例だとこう書かなければいけない。

``` javascript
	$.each(["#main", "#header", "#footer"], function(i, el) {
		$(el + " li a").somePlugin();
	});
```

すごくイケてない感じがするけど、これで一応乗り越えた。

### 追記
`selector`プロパティは[1.9で削除されました](http://api.jquery.com/selector/)。が、1.10で使えるし、2.0でも使えます。便利だけど取り扱いが難しい。
