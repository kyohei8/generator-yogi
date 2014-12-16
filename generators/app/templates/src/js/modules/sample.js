<% if(jslib.indexOf('jquery')>=0){ %>var $;
window.jQuery = $ = require('jquery-2.1.1.min');<% } %>
var SampleModule = (function() {
  function SampleModule(text) {
  <% if(jslib.indexOf('jquery')>=0){ %>
    var title = $('#title').show();
  <%}else{%>
    var title = document.getElementById("title");
    title.style.display = 'block';
  <%}%>
  }

  return SampleModule;

})();

module.exports = SampleModule;
