gulp = require 'gulp'
$ = require('gulp-load-plugins')()
colors = require 'colors'

gulp.task 'build', ['setBuild', 'css:build', <% if(htmlOption === 'jade'){ %>'jade', <% } %>'browserify'], ->
