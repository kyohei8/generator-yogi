<% if(jslib.indexOf('jquery')>=0){ %>window.jQuery = $ = require 'jquery'<% } %>
Module = require './modules/sample'
module = new Module('from main')

<% if(jslib.indexOf('jquery')>=0){ %>$ ->
  ($ '#title').text '<%= _.slugify(projectName) %> is awesome site!'<% }else{ %>(->
  document.addEventListener "DOMContentLoaded", ->
    title = document.getElementById('title')
    title.textContent = '<%= _.slugify(projectName) %> is awesome site!'
)()<% } %>
