gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'install', ->
  gulp.src(['./bower.json', './package.json'])
  .pipe $.install()
