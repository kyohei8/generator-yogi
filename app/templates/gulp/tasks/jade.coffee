gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'

# jade
gulp.task 'jade', ->
  distDir = if global.isStage then config.path.stage.root else config.path.dist.root
  gulp.src "#{config.path.src.root}/**/*.jade"
    .pipe $.plumber
      errorHandler: $.notify.onError (error)->
        "Error: " + error.message
    .pipe $.jade
      pretty:true
    .pipe gulp.dest distDir
    .pipe browserSync.reload
      stream:true
    .pipe $.size
      title: 'html'
