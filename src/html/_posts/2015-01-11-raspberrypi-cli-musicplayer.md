---
layout: post
title: Raspberry Piで軽量ミュージックプレイヤーを動かす
categories: raspberrypi
---
以前[Raspberry PiをAirPlayサーバ化][usbaudio]することに成功しました。もう一歩踏み出して、音楽の再生をRaspberry Piにさせればいいんじゃないか。Mid 2011モデルのMacbook Airの負担をRaspberry Piが肩代りすればいいのではないかと考え、Raspberry Piで音楽を鳴らすことにしました。

## iTuensライブラリをマウント
iTunesはTime CapsuleのNASにあるので、利用できるようにマウントします。sambaでマウントします。まずはcifs-utilsをインストールします。

```bash
sudo apt-get install cifs-utils
```

マウントポイントをホームフォルダに作り、そこにマウントします。

```bash
mkdir -p mnt/disk
sudo mount.cifs //192.168.0.2/AirMacDisk ~/mnt/disk -o sec=ntlm
```

これでiTunesライブラリにアクセスできるようになりました。

## cmus

うちのRaspberry Piは初回セットアップ時を除きsshで操作します。基本的にCUIです。ということはRaspberianにデフォルトでインストールされているであろうミュージックプレイヤーは使いません。代わりにコマンドラインで動く[cmus][cmus]を使います。

パッケージが用意されているので、インストールは簡単です。

```bash
sudo apt-get install cmus
```

実行方法は

```bash
cmus
```

ですが、必ずチュートリアルとドキュメントを読みましょう。  
なぜならcmusはVi likeな操作で動かすミュージックプレイヤーなのです。裏を返すと操るために少しだけ学習が必要なのです。

```bash
man cmus-tutorial
man cmus
```

最低限覚えればいいのは終了方法です。`ESC`キーを押してから`:q`と入力して`Enter`キーでコマンド実行です。Vimのように`:h`でドキュメントを呼び出そうとしても`man cmus-tutorial`か`man cmus`でドキュメントを読みなさいと言われるだけなので、Vimより厳しいです。

初回起動時の流れはキーボードの`5`でファイルブラウザを呼び出して、音楽ファイルの詰まったフォルダを選択し、`a`でライブラリに追加します。スキャンされた曲はキーボードの`1`でライブラリビューが表示されます。`j`,`k`で移動、`c`で再生、一時停止、`+`と`-`で音量調整、`/`に続いて検索キーワードを打ち込んで曲を検索できます。キーボードの`7`でキーバインドを調べることができます。

![cmus](/images/raspberrypi-cli-musicplayer.png)

さて、音楽再生で消費するCPUリソースをRaspberry Piに丸投げすることに成功しました。操作方法は宗教上の理由でハードルになりません。Raspbery PiのLoad Averageは0.14, 0.10, 0.10！しかし、素晴らしいことばかりではありません。

まず、曲をiTunes Storeから買っているからiTunesを使う、手に入れた曲はiTunes Matchに登録したい、iPhoneのアップグレード時にiTunesを使う、たまにiTunesで映画をレンタルする等。結局iTunesを使うわけです。

できることならAppleにはさらに軽量なiTunes[^i_think_itunes]を開発していただきたいところです。

ちなみにcmusはHomebrewに登録されているので、OS Xユーザーは

```bash
brew install cmus
```

でサクッと試せます。もしかしたら無理にRaspberry Piを使う必要はなかったかもしれませんが、何事も挑戦です。

[usbaudio]: /2014/10/30/air-play-usb-audio-raspberrypi.html
[cmus]: https://cmus.github.io

[^i_think_itunes]: iTunes 12は以前よりも軽くなったと思いますよ。
