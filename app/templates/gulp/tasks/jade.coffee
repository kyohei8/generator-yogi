gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'
config = require '../config'

# jade
gulp.task 'jade', ->
  gulp.src "#{config.path.src}/**/*.jade"
    .pipe $.jade
      pretty:true
    .pipe gulp.dest "#{config.path.dist}"
    .pipe browserSync.reload
      stream:true
    .pipe $.size
      title: 'html'