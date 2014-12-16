gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'styledocco', ['css'], ->
  gulp.src "#{config.path.dist.root}/**/*.css"
    .pipe $.styledocco
      out: 'docs'
      name: config.name
