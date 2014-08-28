"use strict"
util = require("util")
path = require("path")
yeoman = require("yeoman-generator")
yosay = require("yosay")

YogiGenerator = yeoman.generators.Base.extend(
  initializing: ->
    @pkg = require("../package.json")

  prompting: ->
    done = @async()

    paths = process.cwd().split("/")
    _dirname = paths[paths.length - 1]
    # Have Yeoman greet the user.
    @log yosay("yo yo gi !")
    @prompt [
      {
        name: "projectName"
        message: "What would you like to name your project?"
        default: _dirname
      }
      {
        type: "list"
        name: "htmlOption"
        message: "Which HTML preprocessor would you like to use?"
        choices: [
          "none(use html)"
          "jade"
        ]
      }
      {
        type: "list"
        name: "cssOption"
        message: "Which CSS preprocessor would you like to use?"
        choices: [
          "none(use css)"
          "scss"
          "less"
          "stylus"
        ]
      }
      {
        type: "list"
        name: "jsOption"
        message: "Which JavaScript preprocessor would you like to use?"
        choices: [
          "none(use javascript)"
          "coffeescript"
          "typescript"
        ]
      }
    ], ((props) ->
          @projectName = props.projectName
          @htmlOption = props.htmlOption
          if props.cssOption is "none(use css)"
            @cssOption = "css"
          else
            @cssOption = props.cssOption
          @jsOption = props.jsOption
          done()
    ).bind(this)

  writing:
    app: ->
      @dest.mkdir 'dist'
      @dest.mkdir 'dist/images'
      @dest.mkdir 'dist/scripts'
      @dest.mkdir 'dist/styles'

      # src
      #html
      if this.htmlOption is 'jade'
        @dest.mkdir 'src/jade'
        @template('src/html/index.jade', 'src/jade/index.jade')
      else
        @template('src/html/index.html', 'dist/index.html')

      # CSS
      if @cssOption is "css"
        #css
        @template "src/css/style.css", "dist/styles/style.css"
      else
        @mkdir "src/" + @cssOption
        if /^(scss|less)$/.test(@cssOption)
          #scss,less
          @template "src/css/style.css", "src/" + @cssOption + "/style." + @cssOption
        else
          #stylus
          @template "src/css/style.styl", "src/" + @cssOption + "/style.styl"

      # JavaScript
      if @jsOption is "coffeescript"
        @mkdir "src/coffee"
        @mkdir "src/coffee/modules"
        @template "src/js/main.coffee", "src/coffee/main.coffee"
        @template "src/js/modules/sample.coffee", "src/coffee/modules/sample.coffee"
      else if @jsOption is "typescript"
        @mkdir "src/ts"
        @mkdir "src/ts/modules"
        @template "src/js/main.ts", "src/ts/main.ts"
        @template "src/js/modules/sample.ts", "src/coffee/modules/sample.ts"
      else
        @template "src/js/main.js", "dist/scripts/main.js"
        @template "src/js/modules/main.js", "dist/scripts/modules/main.js"

    projectfiles: ->
      @copy 'bowerrc', '.bowerrc'
      @copy 'gitignore', '.gitignore'
      @copy 'gulpfile.coffee', 'gulpfile.coffee'
      @template '_package.json', 'package.json'
      @template '_bower.json', 'bower.json'
      @template '_README.md', 'README.md'
      @directory "gulp", "gulp"

  end: ->
    @installDependencies()
)
module.exports = YogiGenerator

###
  TODO
  * jade (gulp-jade?)
  * less
  * stylus
  * ts
  * js(watch)
  * css(watch)
  * heroku(express)
###