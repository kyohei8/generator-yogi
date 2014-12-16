declare var require:any;
var $:any;
var jQuery:any = $ = require("jquery-2.1.1.min");
var Module:any = require('./modules/sample');
var module:any = new Module('from main');

// typescript is WIP...
$(function(){
  $('#title').text('<%= _.slugify(projectName) %> is awesome site!');
});
