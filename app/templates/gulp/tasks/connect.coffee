gulp = require 'gulp'
$ = require('gulp-load-plugins')()
config = require '../config'

gulp.task 'connect', ->
  connect = require 'connect'
  serveStatic = require 'serve-static'
  serveIndex = require 'serve-index'

  app = connect()
    .use(require('connect-livereload')({port: 35729}))
    .use(serveStatic(config.path.dist))
    #.use(serveIndex(config.path.dist))

  http = require 'http'
  http.createServer(app).listen(config.port).on 'listening', ->
    console.log "Start Server on http://#{config.host}:#{config.port}"
