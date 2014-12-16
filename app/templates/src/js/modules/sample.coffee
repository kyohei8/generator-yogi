<% if(jslib.indexOf('jquery')>=0){ %>window.jQuery = $ = require 'jquery-2.1.1.min'<% } %>
class SampleModule
  constructor: (text) ->
    <% if(jslib.indexOf('jquery')>=0){ %>
    title = ($ '#title').show()
    <% }else{ %>
    title = document.getElementById 'title'
    title.style.display = 'block'
    <% } %>
module.exports = SampleModule
