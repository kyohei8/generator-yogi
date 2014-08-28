declare var require:any;
var Modernizr:any = require("browsernizr");
var $:any;
var jQuery:any = $ = require("jquery");
var Module:any = require('./modules/sample');
var module:any = new Module('from main');

$(function(){
  console.log('Hello! <%= _.slugify(projectName) %>');
});