gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'uglify', ->
  distDir = if global.isStage then config.path.stage.scripts else config.path.dist.scripts
  gulp.src("#{distDir}/**/*.js")
    .pipe $.plumber()
    .pipe $.uglify()
    .pipe gulp.dest distDir
