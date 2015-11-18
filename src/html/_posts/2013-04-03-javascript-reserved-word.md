---
layout: post
title: JavaScriptの予約語
categories: js
---
`class`というキーを持ったjsonをjQueryのgetJSONで取得した後、コールバック関数でhtmlタグのクラス名を設定しようとしてハマった。

android 2.2のブラウザでsyntax errorとなりスクリプト実行停止である。ハマった。

	{
		"class": "red-background"
	}

原因は`class`がjavascriptの予約語に入っているから。しかし、android2.2以外ではsyntax errorにならず、スクリプトが実行される不思議。

https://developer.mozilla.org/ja/docs/JavaScript/Reference/Reserved_Words
