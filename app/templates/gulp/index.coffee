fs = require 'fs'
tasks = fs.readdirSync './gulp/tasks/'
global.config = require './config'

tasks.forEach (task)->
  require ".\/tasks\/#{task}"
