declare var require:any;
var Modernizr:any = require("browsernizr");
var $:any;
var jQuery:any = $ = require("jquery");
var Module:any = require('./modules/sample');
var module:any = new Module('from main');

$(function(){
  $('#title').text('<%= _.slugify(projectName) %> is awesome site!');
});
