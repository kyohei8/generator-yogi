gulp = require 'gulp'
$ = require('gulp-load-plugins')()

# coffeelintを通す
gulp.task 'coffeelint', ->
  gulp.src("#{config.path.src.coffee}/**/*.coffee")
    .pipe $.coffeelint './.coffeelint.json'
    .pipe $.coffeelint.reporter()
