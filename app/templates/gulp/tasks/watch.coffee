gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

watchTask = ->
  #coffeeのwatchはbrowserifyでやっている
  gulp.watch "#{config.path.src}/**/*.scss", ['css']
  <% if(htmlOption === 'jade'){ %>gulp.watch "#{config.path.src}/**/*.jade", ['jade']<% } %>

gulp.task 'watch', ['css', 'setWatch', 'browserify', 'serve'], ->
  $.livereload.listen()
  gulp.watch("#{config.path.dist}/**/*").on 'change', (event) ->
    $.livereload.changed(event.path)

  watchTask()

gulp.task 'watch-bs', ['css', 'setWatch', 'browserify', 'browser-sync'], ->
  watchTask()
