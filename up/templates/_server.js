var connect = require('connect');
var serveStatic = require('serve-static');
var auth = require('basic-auth');

var app = connect();
app.use(function(req, res, next){
  <% if(ba.name){%> //basic auth
  var credentials = auth(req);
  if(!credentials || credentials.name !== "<%= ba.name %>" || credentials.pass !== "<%= ba.pass %>"){
    res.writeHead(401, {
      'WWW-Authenticate': 'Basic realm="example"'
    });
    res.end('Authorization Required.');
  }else{
    next();
  }
  <% }else{%>next();<% } %>
});
app.use(serveStatic(__dirname));
app.listen(process.env.PORT || 3000);
