gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'

# sassのcompileとautoprefixer、minify用のcsso
gulp.task 'css', ->
  gulp.src "#{config.path.src.css}/**/*.<%= cssOption %>"<% if(cssOption === 'scss'){ %>
    .pipe $.sass
      errLogToConsole:true<% } %><% if(cssOption === 'less'){ %>
    .pipe $.less()<% } %><% if(cssOption === 'styl'){ %>
    .pipe $.stylus()<% } %>
    .pipe $.autoprefixer config.autoprefixer_browsers
    .pipe $.csso()
    .pipe gulp.dest "#{config.path.dist.styles}/"
    .pipe $.base64
      debug:true
    .pipe gulp.dest "#{config.path.dist.styles}/"
    .pipe browserSync.reload
      stream:true
    .pipe $.size
      title: 'css'
