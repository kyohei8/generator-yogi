gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

# Static server
gulp.task 'browser-sync', ->
  browserSync = require 'browser-sync'
  browserSync
    server:
      baseDir: config.path.dist
    files:['dist/**/*']