gulp = require 'gulp'
$ = require('gulp-load-plugins')()

# coffeelintを通す
gulp.task 'coffeelint', ->
  gulp.src("#{config.path.src.coffee}/**/*.coffee")
    .pipe $.coffeelint
      max_line_length:
        value: 120
    .pipe $.coffeelint.reporter()
