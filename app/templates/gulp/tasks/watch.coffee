gulp = require 'gulp'
$ = require('gulp-load-plugins')()

watchTask = ->
  gulp.watch "#{config.path.src.root}/**/*.<%= cssOption %>", ['css']
  gulp.watch "#{config.path.src.root}/**/*.<%= htmlOption %>", ['<%= htmlOption %>']

gulp.task 'watch', ['install','<%= htmlOption %>', 'css', 'setWatch', 'browserify', 'serve'], ->
  $.livereload.listen()
  gulp.watch("#{config.path.dist.root}/**/*").on 'change', (event) ->
    $.livereload.changed(event.path)

  watchTask()

gulp.task 'watch-bs', ['install','<%= htmlOption %>', 'css', 'setWatch', 'browserify', 'browser-sync'], ->
  watchTask()
