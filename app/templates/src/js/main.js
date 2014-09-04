var $, Modernizr, Module, module;

Modernizr = require('browsernizr');
window.jQuery = $ = require('jquery');
Module = require('./modules/sample');
module = new Module('from main');

$(function() {
  $('#title').text('<%= _.slugify(projectName) %> is awesome site!');
});
