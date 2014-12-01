# generator-yogi (WIP) [![Build Status](https://secure.travis-ci.org/kyohei8/generator-yogi.png?branch=master)](https://travis-ci.org/kyohei8/generator-yogi)

> [Yeoman](http://yeoman.io) generator

The tools that are available in my recent frontend development it tried to generater. (WIP)

## Feature

### generate template

```
$ mkdir <projectName> && cd <projectName>
$ yo yogi
```

* template engine  
you can pick the template engine, `html` or `jade` .
* CSS preprocessor  
in the same way, `css` or `sass` or `less` or `stylus`.
* JavaScript preprocessor  
in the same way, `JavaScript` or `CoffeeScript` or `typescript`.

* and use js library (Option)  
 * jQuery
 * Modernizr


### deploy to server

you can deploy dist files to http server(heroku).

#### prepare for setup

To install heroku toolbelt.
https://toolbelt.heroku.com/

and login 

```
$ heroku login
```

#### deploy (for first time)

```
$ yo yogi:up
```
`_stage` directory is created in you're projects, It will deploy there directory to heroku.


#### deploy (second time or after)

```
$ yo yogi:deploy
```


## Getting Started

coming soon. :)

<!--
```bash
npm install -g yo
```

```bash
npm install -g generator-yogi
```

Finally, initiate the generator:

```bash
yo yogi
```
-->

## Development

```
$ git clone git@github.com:kyohei8/generator-yogi.git
$ cd generator-yogi
$ npm link
```

then, you'll be able to call

```
yo yogi
```

## License

MIT
