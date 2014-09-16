gulp = require 'gulp'
$ = require('gulp-load-plugins')()

watchTask = ->
  gulp.watch "#{config.path.src.root}/**/*.<%= cssOption %>", ['css']
  <% if(htmlOption === 'jade'){ %>gulp.watch "#{config.path.src.root}/**/*.jade", ['jade']<% } %>

gulp.task 'watch', ['css', <% if(htmlOption === 'jade'){ %>'jade', <% } %>'setWatch', 'browserify', 'serve'], ->
  $.livereload.listen()
  gulp.watch("#{config.path.dist.root}/**/*").on 'change', (event) ->
    $.livereload.changed(event.path)

  watchTask()

gulp.task 'watch-bs', ['css', <% if(htmlOption === 'jade'){ %>'jade', <% } %>'setWatch', 'browserify', 'browser-sync'], ->
  watchTask()
