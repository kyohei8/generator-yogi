gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'

# css compile
gulp.task 'css', ->
  gulp.src "#{config.path.src.css}/**/*.<%= cssOption %>"
    .pipe $.plumber<% if(cssOption === 'scss'){ %>()<% }else{ %>
      errorHandler: $.notify.onError (error)->
        "Error: " + error.message<% } %><% if(cssOption === 'scss'){ %>
    .pipe $.sass
      onError: $.notify.onError
        onError: true<% } %><% if(cssOption === 'less'){ %>
    .pipe $.less()<% } %><% if(cssOption === 'styl'){ %>
    .pipe $.stylus()<% } %>
    .pipe $.autoprefixer config.autoprefixer_browsers
    .pipe gulp.dest "#{config.path.dist.styles}/"
    .pipe browserSync.reload
      stream:true
    .pipe $.size
      title: 'css'

# for build
gulp.task 'css:build', ['css'], ->
  gulp.src "#{config.path.dist.styles}/**.css"
  .pipe $.base64
    debug:true
  .pipe $.csso()
  .pipe gulp.dest "#{config.path.dist.styles}/"
