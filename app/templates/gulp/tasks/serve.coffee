gulp = require 'gulp'
config = require '../config'

gulp.task 'serve', ['connect'], ->
  require('opn')("http://#{config.host}:#{config.port}")
