gulp = require 'gulp'

# Static server
gulp.task 'browser-sync', ->
  browserSync = require 'browser-sync'
  browserSync
    server:
      baseDir: config.path.dist.root
    files:["#{config.path.dist.root}/**/*"]
