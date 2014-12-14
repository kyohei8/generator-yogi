<% if(jslib.indexOf('jquery')>=0){ %>window.jQuery = $ = require 'jquery'<% } %>
class SampleModule
  constructor: (text) ->
    <% if(jslib.indexOf('jquery')>=0){ %>
    title = ($ '#title').text("#{text} is awesome site!")
    <% }else{ %>
    title = document.getElementById('title')
    title.textContent = "#{text} is awesome site!"
    <% } %>
module.exports = SampleModule
