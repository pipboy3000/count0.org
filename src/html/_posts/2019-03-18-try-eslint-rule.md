---
layout: post
title: ESLintのルール作成に挑戦
categories: js
---

JavaScriptを書くときに欠かせないのがESLint(そしてprettier)。ふと思う。ESlintで独自ルールはどう書くのか？この単純な疑問を解決するために、自作ルールを書いてみた。

[https://github.com/pipboy3000/eslint-plugin-no-hyogo-police](https://github.com/pipboy3000/eslint-plugin-no-hyogo-police)

とても簡単な無限ループを書いてしまったときに警告するルールである。リポジトリ名で出落ち感はある。実用性はゼロだ。

```js
while(true) {
  alert('貴様はこれを閉じれない')
}
```

上記のようなコードを書くと、`They are watching you from Hyogo.`という警告メッセージを表示するようになっている。

ESLintは仕組みが整っているので、簡単に実現できた。whileの無限ループの部分だけリポジトリからコードを抜粋すると

```js
module.exports = {
  create: function(context) {
    function report(node) {
      context.report({ node, messageId: 'theyWatch' })
    }
    return {
      WhileStatement: function(node) {
        if (
          node.test.type !== "BinaryExpression" &&
          node.test.name !== "undefined" &&
          node.test.value !== null &&
          node.test.value !== false &&
          node.test.value !== 0
        ) {
          report(node)
        }
      }
    };
  }
};
```

`WhileStatement`や`BinaryExpression`はなんぞや？これは[AST Exploer](https://astexplorer.net/)で得られた抽象構文木である。

話は前後するが、最初にテストコードを書く。これも仕組みが整っている。テストコード全文を掲載すると

```js
var RuleTester = require("eslint").RuleTester;

var tester = new RuleTester();
tester.run('infinite_loop', require('../../../lib/rules/infinite-loop'), {
  valid: [
    { code: "while(n < 3){}" },
    { code: "while(false){}" },
    { code: "while(null){}" },
    { code: "while(undefined){}" },
    { code: "while(0){}" },
    { code: "for(var i = 0; i < 10; i++) {}" }
  ],
  invalid: [
    { code: "while(true){}", errors: ["They are watching you from Hyogo."] },
    { code: "while(1){}", errors: ["They are watching you from Hyogo."] },
    { code: "while('a'){}", errors: ["They are watching you from Hyogo."] },
    { code: "for(;;){}", errors: ["They are watching you from Hyogo."] },
    { code: "for(var i = 0;;i++){}", errors: ["They are watching you from Hyogo."] },
    { code: "for(var i = 0; i = 1;i++){}", errors: ["They are watching you from Hyogo."] }
  ]
})
```

`valid`にOKなコード、`invalid`に警告を出したいコードと警告メッセージを書く。このテストがオールグリーンになるまでルールの方を書いていくという流れ。

---

予想よりも簡単にESLintの独自ルールが書けた。仕組みが整っているのは素晴らしい。ルールに穴があるし、頭に書いたように実用性ゼロだが、まあいいでしょう。

余談だが、GitHubでコードを公開している警察はあるのか調べたら、[あった](https://github.com/politie)。すげくサイバーだ。

### ご参考に

* [ESLint のカスタムルールを作ろう! (その1)](https://qiita.com/mysticatea/items/cc3f648e11368799e66c)  
  この記事が作り方について0から書かれている。とてもわかりやすい。
* [Working with Rules](https://eslint.org/docs/developer-guide/working-with-rules)  
  ESLint公式ドキュメント。ディレクトリ構成の参考に。
* [Working with Plugins](https://eslint.org/docs/developer-guide/working-with-plugins)  
  ESLint公式ドキュメント。プラグインとしての体裁を整えるために。

