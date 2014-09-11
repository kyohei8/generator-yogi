gulp = require 'gulp'
$ = require('gulp-load-plugins')()

gulp.task 'connect', ->
  connect = require 'connect'
  serveStatic = require 'serve-static'

  app = connect()
    .use(require('connect-livereload')({port: config.ports.livereload}))
    .use(serveStatic(config.path.dist.root))

  http = require 'http'
  http.createServer(app)
    .listen(config.ports.server)
    .on 'listening', ->
      console.log "Start Server on http://#{config.host}:#{config.ports.server}"
