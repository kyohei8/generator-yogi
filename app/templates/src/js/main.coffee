Modernizr = require 'browsernizr'
window.jQuery = $ = require 'jquery'

Module = require './modules/sample'
module = new Module('from main')

$ ->
  console.log 'Hello! <%= _.slugify(projectName) %>'