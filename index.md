---
layout: default
title: Generator yogi
---

## インストール

#### 1. [node.js](http://nodejs.org/)(>=v0.10)をインストール

```bash
$ node -v
v0.10.33
```

#### 2. yeoman（generatorのgenerator）をインストール

```bash
$ sudo npm install -g yo
```

#### 3. bower, gulp をインストール
```bash
$ sudo npm install -g bower
$ sudo npm install -g gulp
```

#### 4. generator-yogiをインストール
```bash
$ npm install -g generator-yogi
```

## 実行

#### 1. お好きなディレクトリを作成してcd
```
$ mkdir my-new-project && cd $_
```

#### 2. yo yogiと入力
おっさんが出てくるので、enterを押す
出てくる選択肢をspaceキーで選んでいく
完成！

###■できること

・sassコンパイル
・プレフィクス勝手につけてくれる
・@@include でhtmlをパーツ単位でincludeできる
・ローカルサーバ(localhost)を立ち上げてくれる
・livereload（cssとかを更新したら勝手にブラウザ側も更新してくれる）

### gulp command

#### watch
メインとなるwatchコマンドは2つ

```
$ gulp watch
```
各種ファイルをコンパイルし、ローカルサーバを建てる

```
$ gulp watch-bs
```
各種ファイルをコンパイルし、Browser-syncを利用したローカルサーバを建てる

