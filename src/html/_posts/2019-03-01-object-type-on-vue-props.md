---
layout: post
title: Vue.jsでObject型のPropsにTypeScriptの型を割り当てる
categories: js TypeScript
---

Vue.jsのPropsはObjectを渡せるので、コンポーネントに情報の塊を渡すことができて便利。型指定すると以下のようになる。

```js
const person = {
  first_name: 'Asai',
  last_name: 'Masami'
};

Vue.extend({
  name: 'personal-info',
  props: {
    person: {
      type: Object
    },
  },
});

<personal-info v-bind:person="person" />

```

👆のコードはTypeScriptでもObject型として通用する。しかし、Objectではanyすぎる。別途定義した型を使いたい。それでどう書くか。

```ts
interface Person {
  first_name: string;
  last_name: string;
}

Vue.extend({
  name: 'personal-info',
  props: {
    person: {
      type: Object as () => Person,
    },
  },
});

const person: Person = {
  first_name: 'Asai',
  last_name: 'Masami'
};

<personal-info v-bind:person="person" />

```

これでよし。ちがう型のObjectを渡すと当然TypeScriptに怒られる。中年になると怒られることもなくなるので、たまには怒られてみるのもいいかも。

### ご参考に

* [Vue + TypeScriptでpropsのObjectやArrayに型をつける](https://qiita.com/iMasanari/items/31d8a26c7ee22793585c)
* [Using a Typescript interface or type as a prop type in VueJS](https://frontendsociety.com/using-a-typescript-interfaces-and-types-as-a-prop-type-in-vuejs-508ab3f83480)
