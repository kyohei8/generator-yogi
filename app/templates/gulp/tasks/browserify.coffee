gulp = require 'gulp'
$ = require('gulp-load-plugins')()

browserify = require 'browserify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
colors = require 'colors'
config = require '../config'
browserSync = require 'browser-sync'
fs = require 'fs'

# srcの.coffeeファイルを取得
fileNames = fs.readdirSync("./#{config.path.src}/coffee/")
  .filter((file)->
    file.split('.').pop() is 'coffee'
  ).map((file)->
    file.split('.').shift()
  )

files = []
# 処理するファイルリストを生成
fileNames.forEach (fn)->
  files.push
    input      : "./#{config.path.src}/coffee/#{fn}.coffee"
    output     : "#{fn}.js"
    extensions : '.coffee'
    destination: "#{config.path.dist}/scripts/"

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

gulp.task 'browserify', ['coffeelint'], ->
  createBundles(files)
