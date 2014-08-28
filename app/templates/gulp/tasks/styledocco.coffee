gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'styledocco', ['css'], ->
  gulp.src "#{config.path.dist}/**/*.css"
    .pipe $.styledocco
      out: 'docs'
      name: config.name
