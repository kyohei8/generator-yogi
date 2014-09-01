gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'watch', ['css', 'setWatch', 'browserify', 'serve'], ->
  $.livereload.listen()

  gulp.watch([
    "#{config.path.dist}/**/*.html"
    "#{config.path.dist}/**/*.css"
    "#{config.path.dist}/**/*.js"
  ]).on 'change', $.livereload.changed

  #coffeeのwatchはbrowserifyでやっている
  gulp.watch "#{config.path.src}/**/*.scss", ['css']

gulp.task 'watch-bs', ['css', 'setWatch', 'browserify', 'browser-sync'], ->
  gulp.watch "#{config.path.src}/**/*.scss", ['css']