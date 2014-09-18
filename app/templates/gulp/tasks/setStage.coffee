gulp = require 'gulp'

gulp.task 'setStage', ->
  global.isStage = true
  distDir = config.path.dist.root
  stageDir = config.path.stage.root
  # copy images, bower_compornents
  gulp.src "#{distDir}/images/**/*"
    .pipe gulp.dest "#{stageDir}/images"
  gulp.src "#{distDir}/bower_components/**/*"
    .pipe gulp.dest "#{stageDir}/bower_components"<% if(cssOption === 'css'){ %>
  gulp.src "#{config.path.dist.styles}/**/*"
    .pipe gulp.dest "#{config.path.stage.styles}/"<% } %><% if(htmlOption === 'html'){ %>
  gulp.src "#{distDir}/**/*.html"
    .pipe gulp.dest "#{stageDir}/"<% } %>
