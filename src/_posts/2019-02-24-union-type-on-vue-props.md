---
layout: post
title: Vue.jsのPropsでUnion Type
categories: js TypeScript
---

Vue.jsでコンポーネントを作っているとき、String型を指定されているPropsで数字(Number)が扱いたくてUnion Type的なことできないか[ググったら答えが出てきた](https://forum.vuejs.org/t/vue-component-property-types-are-union-types-possible/10300)。たぶんドキュメントに載ってないんじゃないかな、これ。

```js
Vue.extend({
  props: {
    value: {
      type: [String, Number]
    }
  }
})
```

Propsの型を無視してもJavaScriptで書いていたらwarningが出る程度だが、TypeScriptで書いているとちゃんと止めてくれるのだ。

