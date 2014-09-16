gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'

# jade
gulp.task 'jade', ->
  gulp.src "#{config.path.src.root}/**/*.jade"
    .pipe $.plumber
      errorHandler: $.notify.onError (error)->
        "Error: " + error.message
    .pipe $.jade
      pretty:true
    .pipe gulp.dest "#{config.path.dist.root}"
    .pipe browserSync.reload
      stream:true
    .pipe $.size
      title: 'html'
