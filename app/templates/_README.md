# <%= _.slugify(projectName) %>

## SLA
#### for PC
* IE9 - 11 (Win)
* Firefox latest (Win/Mac)
* Chrome latest (Win/Mac)
* Safari 6,7 (Mac)

#### for SP

* iOS Safari
* Android Browser/Chrome

## tool

* [gulp.js](http://gulpjs.com/) タスクランナー
* [Browserify]() Browserify
* [Bower](http://bower.io/)　パッケージ管理<% if(htmlOption === 'jade'){ %>
* [Jade](http://jade-lang.com/) htmlプリコンパイラ <% } %><% if(cssOption === 'scss'){ %>
* [Sass](http://sass-lang.com/) cssプリコンパイラ <% } %><% if(cssOption === 'less'){ %>
* [Less](http://lesscss.org/) cssプリコンパイラ<% } %><% if(cssOption === 'styl'){ %>
* [stylus](http://learnboost.github.io/stylus/) cssプリコンパイラ <% } %><% if(jsOption === 'coffeescript'){ %>
* [CoffeeScript](http://coffeescript.org/) jsプリコンパイラ<% } %>
* [Mocha](http://visionmedia.github.io/mocha/) + [Chai](http://chaijs.com/) テストフレームワーク

#### テンプレートエンジン

* 特になし

#### jsライブラリ

* jQuery 2.1.1
* Modernizr 2.8.3

　

## インストール方法

#### node.jsをインストール (v0.10以上)

http://nodejs.org/  
インストール方法は割愛


#### gulpをインストール
（既にインストールしていれば不要）

```
$ npm install -g gulp
```

#### bowerをインストール
（既にインストールしていれば不要）

```
$ npm install -g bower
```

### git clone

```
# リポジトリをクローンして、プロジェクトのディレクトリに移動
$ git clone http://(git repository)<%= _.slugify(projectName) %>.git
$ cd <%= _.slugify(projectName) %>
```

#### npmパッケージをインストール

```
$ npm install
```

#### bowerパッケージをインストール

```
$ bower install
```

## gulp タスク

```
$ gulp watch
```
* ローカルサーバーを起動
* ブラウザで http://localhost:9000 が自動で開く
* 各ファイルをwatchする

```
$ gulp watch-bs
```
上記のbrowser-sync版

---
```
$ gulp stage
```
ソースコードをビルドして`stage`ディレクトリに配置します
