gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'uglify', ->
  gulp.src("#{config.path.dist.scripts}/*.js")
    .pipe($.uglify())
    .pipe(gulp.dest("#{config.path.dist.scripts}"))
