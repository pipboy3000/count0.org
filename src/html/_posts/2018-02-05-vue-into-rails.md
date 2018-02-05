---
layout: post
title: RailsにVue.jsを小さく導入する
categories: ruby
---
先月開催された[フロントエンドもくもく会 - 新年LT大会][mokumoku-lt]というイベントで
「RailsにVue.jsを小さく導入する」というLTを発表したが、あえなく時間切れになってしまった。

LTはTurbolinksはどんなもので、敬遠されがちという説明で終わってしまったので、
続きをブログに書くことにした。

## 前提

どんなRailsアプリケーションにVue.jsを導入したかというと

* Rails 5.0で作られ、現在Rails 5.1を使っている
* Turbolinksを使っている
* **jQuery**に依存している
* APIやjbuilderでJSONを返しては**くれない**

RailsをAPIに専念させ、フロントエンドをSPAで実装するには時既に遅しである。

## Vue.jsのインストール

まずはWebpackerでVue.jsを導入することにする。導入方法は[webpackerのREADME][webpacker]を参照すればよいので割愛する。

webpackのエントリーポイントは`app/javascript/packs/main.js`とした。

レールに乗っかれるのはここまで。あとはご自由にという感じである。

## 基本

Vue.jsはコンパイラ付きの完全版を使い、Turbolinksと共存させたいので、[vue-turbolinks][vue-turbolinks]を使う。`turbolinks:load`イベントでVueコンポーネントをマウントする。コンポーネントのマウント先はViewテンプレートに記述したIDになる。

``` slim
/ RailsのViewテンプレート.slim
#mount-point
```

``` javascript
/* app/javascript/packs/main.js */
import Vue from 'vue/dist/vue.esm';
import ComponentA from 'components/ComponentA.vue'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('mount-point')) {
    new Vue({
      name: 'SampleComponent',
      el: '#mount-point',
      template: '<ComponentA/>'
      components: {
        ComponentA
      },
    });
  }
});
```

`div#mount-point`に`ComponentA`がマウントされる。これで任意のViewテンプレート内にVue.jsを導入できる。小さく導入できた。

## 応用

コンパイラを含むVue.jsの完全版を利用しているので、DOMテンプレートを利用できる。
以下のようにRailsのコントローラーから渡された変数をVue.jsのコンポーネントに受け渡すことができる。


``` slim
/ RailsのViewテンプレート.slim
#mount-point
  component-a(some-prop=@item.id)
  component-b
```

``` javascript
/* app/javascript/packs/main.js */
import Vue from 'vue/dist/vue.esm';
import ComponentA from 'components/ComponentA.vue'
import ComponentB from 'components/ComponentB.vue'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('mount-point')) {
    new Vue({
      name: 'SampleComponent',
      el: '#mount-point',
      components: {
        ComponentA,
        ComponentB
      },
    });
  }
});
```

RailsということでActionView::FormHelperも使える。こんなこともできるが、これは横着である。

``` slim
/ RailsのViewテンプレート.slim
= form_with model: Item.new do |f|
  .form-group#mount-point
    = f.text_field :name,
                   class: 'form-control',
                   'v-model.trim' 'nameValue',
                   'v-on:blur': 'checkValue'
```

``` javascript
/* app/javascript/packs/main.js */
import Vue from 'vue/dist/vue.esm';
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('mount-point')) {
    new Vue({
      name: 'SampleComponent',
      el: '#mount-point',
      data: function() {
        return {
          nameValue: ''
        }
      },
      methods: {
        checkValue: function() {
          if (this.nameValue.length < 3) {
            // 何かしらの処理
          }
        }
      }
    });
  }
});
```

さらに`body`タグにマウントポイントを設定すればよいのでは？と試したら動作するが、既存のjQueryプラグインや[Chartkick(Ruby版)][chartkick]が動作しなくなってしまったので断念した。順次Vueに移行していけば解決する見通しはある。

## 注意点

上記の方法を使えばページ内にVueコンポーネントを展開できる。例では一つだが、必要に応じて何個もVueコンポーネントを展開できる。

ただし、それぞれのコンポーネント間で**状態**を共有したい場合はVuexを使う必要がある。

また、vue-turbolinksはソースコードが短いので一読をすすめるが、その動作はページを移動するごとにVueコンポーネントは破棄している。よって、ページをまたいで**状態**を維持したい場合、自分は[vue-persistedstate][vue-persistedstate]で状態を永続化と復元をしている。

やはりTurbolinksなのでSPAのような動きをしているが、違うのである。

その他にVue.jsはDOMをテンプレートとして利用できるが、[特有の注意事項][vue-dom-template]を理解した上で利用するとよい。

## まとめ

* Turbolinksは共存できる。
* RailsのViewとVueが混在していてカオスであるが、受け入れればなんとかなる。
* これを5分のLTで説明するのは無理だ。

[mokumoku-lt]: https://html5nagoya.connpass.com/event/74096/
[mokumoku-lt-moment]: https://twitter.com/i/moments/954747737324441600
[webpacker]: https://github.com/rails/webpacker
[vue-turbolinks]: https://github.com/jeffreyguenther/vue-turbolinks
[vue-persistedstate]: https://github.com/robinvdvleuten/vuex-persistedstate
[chartkick]: https://www.chartkick.com/
[vue-dom-template]: https://jp.vuejs.org/v2/guide/components.html#DOM-%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88%E8%A7%A3%E6%9E%90%E3%81%AE%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A0%85
