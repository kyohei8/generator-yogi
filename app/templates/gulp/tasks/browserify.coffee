gulp = require 'gulp'
$ = require('gulp-load-plugins')()

browserify = require 'browserify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
browserSync = require 'browser-sync'
fs = require 'fs'

gulp.task 'browserify', <% if(jsOption === 'coffeescript'){ %>['coffeelint'],<% } %> ->
  distDir = if global.isStage then config.path.stage.scripts else config.path.dist.scripts
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
      destination: distDir

  createBundles(files)


createBundle = (option) ->
  b = browserify
    cache: {}
    packageCache: {}
    fullPaths: false
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
  .on 'error', $.notify.onError
    onError: true
  .on 'end', ->
    time = (new Date().getTime() - sTime) / 1000
    $.util.log "#{option.output.cyan} was browserified: #{(time + 's').magenta}"
    # for build
    if global.isBuild
      gulp.src "#{option.destination}/#{option.output}"
        .pipe $.uglify()
        .pipe gulp.dest(option.destination)
        .pipe $.size
          title: option.output.cyan
  .pipe $.plumber()
  .pipe source(option.output)
  .pipe gulp.dest(option.destination)
  .pipe browserSync.reload
    stream:true
    once: true

createBundles = (bundles) ->
  bundles.forEach (bundle) ->
    createBundle bundle

