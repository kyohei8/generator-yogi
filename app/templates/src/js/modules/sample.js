<% if(jslib.indexOf('jquery')>=0){ %>var $;
window.jQuery = $ = require('jquery-2.1.1.min');<% } %>
var SampleModule = (function() {
  function SampleModule(text) {
  <% if(jslib.indexOf('jquery')>=0){ %>
    var title = $('#title').text(text + ' is awesome site!');
  <%}else{%>
    var title = document.getElementById('title');
    title.textContent = text + ' is awesome site!';
  <%}%>
  }

  return SampleModule;

})();

module.exports = SampleModule;
