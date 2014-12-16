gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'stage', ['setStage', 'html', 'css:build', <% if(htmlOption === 'jade'){ %>'jade', <% } %>'browserify'], ->
