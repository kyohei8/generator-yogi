gulp = require 'gulp'
$ = require('gulp-load-plugins')()
colors = require 'colors'

gulp.task 'stage', ['setStage', 'css:build', <% if(htmlOption === 'jade'){ %>'jade', <% } %>'browserify'], ->
