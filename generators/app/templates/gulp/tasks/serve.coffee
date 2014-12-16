gulp = require 'gulp'

gulp.task 'serve', ['connect'], ->
  require('opn')("http://#{config.host}:#{config.ports.server}")
