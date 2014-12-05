"use strict"
util = require("util")
path = require("path")
yeoman = require("yeoman-generator")
yosay = require("yosay")
superb = require('superb')

YogiGenerator = yeoman.generators.Base.extend(
  initializing: ->
    @pkg = require("../package.json")

  prompting: ->
    done = @async()

    paths = process.cwd().split("/")
    _dirname = paths[paths.length - 1]
    # Have Yeoman greet the user.
    @log yosay('Welcome to the ' + superb() + ' Front-End generator.')
    @prompt [
      {
        name: "projectName"
        message: "What would you like to name your #{superb()} project?"
        default: _dirname
      }
      {
        type: "list"
        name: "htmlOption"
        message: "Which HTML preprocessor would you like to use?"
        choices: [{
          name: 'none(use html)'
          value: 'html'
        },{
          name: 'jade'
          value: 'jade'
        }]
      }
      {
        type: "list"
        name: "cssOption"
        message: "Which CSS preprocessor would you like to use?"
        choices: [{
          name: 'none(use css)'
          value: 'css'
        },{
          name: 'scss'
          value: 'scss'
        },{
          name: 'less'
          value: 'less'
        },{
          name: 'stylus'
          value: 'styl'
        }]
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
      {
        type: "checkbox"
        name: "jslib"
        message: "Select a JavaScript library to use"
        choices: [
          {
            name:'jQuery(2.1.1)'
            value: 'jquery'
            checked: true
          }
          {
            name:"Modernizr(2.8.3)"
            value: 'modernizr'
            checked: false
          }
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
          @jslib = props.jslib
          done()
    ).bind(this)

  writing:
    app: ->
      @dest.mkdir 'dist'
      @dest.mkdir 'dist/images'
      @dest.mkdir 'dist/scripts'
      @dest.mkdir 'dist/styles'
      @copy 'src/images/gulp-2x.png', 'dist/images/gulp-2x.png'

      # src
      #html
      @template "src/html/index.#{this.htmlOption}", "src/#{this.htmlOption}/index.#{this.htmlOption}"
      partsDir = if this.htmlOption is 'html' then "src/html/_parts" else "src/html/_parts_jade"
      @directory partsDir, "src/#{this.htmlOption}/_parts"


      # CSS
      if @cssOption is "css"
        #css
        @template "src/css/style.css", "dist/styles/style.css"
      else
        @mkdir "src/" + @cssOption
        ext = if /^(scss|less)$/.test(@cssOption) then 'css' else 'styl'
        @template "src/css/style.#{ext}", "src/#{@cssOption}/style.#{@cssOption}"

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
        @template "src/js/main.js", "src/scripts/main.js"
        @template "src/js/modules/sample.js", "src/scripts/modules/sample.js"

    projectfiles: ->
      @copy 'bowerrc', '.bowerrc'
      @copy 'gitignore', '.gitignore'
      @copy 'coffeelint.json', '.coffeelint.json'
      @copy 'gulpfile.coffee', 'gulpfile.coffee'
      @template '_package.json', 'package.json'
      @template '_bower.json', 'bower.json'
      @template '_README.md', 'README.md'
      @directory "gulp", "gulp"

  end: ->
    @installDependencies()
)
module.exports = YogiGenerator
