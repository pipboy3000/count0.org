---
layout: post
title: Stimulusでコントローラー間のデータやりとり
categories: js
---

Stimulusでコントローラー間のデータやりとりはどうすればいいのか？

調べてみると[カスタムイベント](https://developer.mozilla.org/ja/docs/Web/Guide/Events/Creating_and_triggering_events)を使う手法が紹介されていた。

[Communicating between Stimulus controllers using custom events](https://fullstackheroes.com/stimulusjs/create-custom-events/)

リンク先のコードが十分小さいので理解しやすいが、「+1」ボタンをクリックすると結果に足される例。

ボタンと結果が別のコントローラーである。

HTMLではボタンに`countup`コントローラーを割り当て、クリックすると`countup`コントローラーの`click`メソッドが呼び出される。その結果カスタムイベント`plusone`が発信される。

一方`result`コントローラーは`plusone`イベントを`update`メソッドで処理するようになっている。

```html
<button data-controller="countup" data-action="click->countup#click">+1</button>

<div data-controller="result" data-action="plusone@window->result#update"></div>
```

`click`メソッドでカスタムイベントを作って`detail`プロパティに渡したい値を設定する。そして`dispatchEvent`でカスタムイベントを発信。

```js
// countup_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  click() {
    const event = new CustomEvent('plusone', { detail: 1 })
    window.dispatchEvent(event);
  }
}
```

上記のカスタムイベントの`detail`プロパティを好きなように処理する。この場合は合計に足して、HTMLに結果を表示するようにしている。

```js
// result_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
    this.sum = 0;
    this.element.innerHTML = this.sum;
  }

  update(event) {
    if (event.detail) {
      this.sum += event.detail;
      this.element.innerHTML = this.sum;
    }
  }
}

```

カスタムイベントすごい便利で簡単！という印象だが、これ以上複雑になったらどうしようという心配もある。