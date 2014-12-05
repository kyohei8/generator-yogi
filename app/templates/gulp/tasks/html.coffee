gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'

# html include
gulp.task 'html', ->
  distDir = if global.isStage then "#{config.path.stage.root}/" else "#{config.path.dist.root}/"
  src = config.path.src.root
  gulp.src [
    "#{src}/html/**/*.html"
    "!#{src}/html/_**/*.html"
  ]
  .pipe $.plumber
    errorHandler: $.notify.onError (error)->
      "Error: " + error.message
  .pipe $.fileInclude
    prefix: '@@'
    basepath: "#{config.path.src.html}/_parts"
  .pipe gulp.dest "#{distDir}/"
  .pipe browserSync.reload
    stream:true
  .pipe $.size
    title: 'html'
