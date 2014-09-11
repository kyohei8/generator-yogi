fs = require 'fs'
tasks = fs.readdirSync './gulp/tasks/'
require './config'

tasks.forEach (task)->
  require ".\/tasks\/#{task}"
