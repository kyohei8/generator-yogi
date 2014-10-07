var Modernizr = require('browsernizr');
<% if(jslib.indexOf('jquery')>=0){ %>var $;
window.jQuery = $ = require('jquery');<% } %>
var Module = require('./modules/sample');
var module = new Module('from main');

<% if(jslib.indexOf('jquery')>=0){ %>$(function() {
  $('#title').text('<%= _.slugify(projectName) %> is awesome site!');
});<%}else{%>(function () {
  document.addEventListener('DOMContentLoaded', function(){
    var title = document.getElementById('title');
    title.textContent = '<%= _.slugify(projectName) %> is awesome site!';
  });
})();<% } %>

