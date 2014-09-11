gulp = require 'gulp'
$ = require('gulp-load-plugins')()

browserify = require 'browserify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
colors = require 'colors'
browserSync = require 'browser-sync'
fs = require 'fs'

gulp.task 'browserify', <% if(jsOption === 'coffeescript'){ %>['coffeelint'],<% } %> ->
  dir = <% if(jsOption === 'coffeescript'){ %>'coffee'<%}else{%>'scripts'<%}%>
  ext = <% if(jsOption === 'coffeescript'){ %>'coffee'<%}else{%>'js'<%}%>
  # srcのファイルを取得
  fileNames = fs.readdirSync("./#{config.path.src.root}/#{dir}/")
    .filter((file)->
      file.split('.').pop() is ext
    ).map((file)->
      file.split('.').shift()
    )

  files = []
  # 処理するファイルリストを生成
  fileNames.forEach (fileName)->
    files.push
      input      : "./#{config.path.src.root}/#{dir}/#{fileName}.#{ext}"
      output     : "#{fileName}.js"
      extensions : ".#{ext}"
      destination: "#{config.path.dist.scripts}"

  createBundles(files)


createBundle = (option) ->
  b = browserify
    cache: {}
    packageCache: {}
    fullPaths: true
    extensions: option.extensions

  if global.isWatching
    b = watchify(b)
    b.on 'update', ->
      rebundle(b, option);
  # add input file
  b.add option.input
  rebundle(b, option);

rebundle = (b, option) ->
  sTime = new Date().getTime()
  b.bundle()
  .on 'error', (e) -> console.log e.message
  .on 'end', ->
    time = (new Date().getTime() - sTime) / 1000
    $.util.log "#{option.output.cyan} was browserified: #{(time + 's').magenta}"
  .pipe source(option.output)
  .pipe gulp.dest(option.destination)
  .pipe browserSync.reload
    stream:true
    once: true

createBundles = (bundles) ->
  bundles.forEach (bundle) ->
    createBundle bundle

