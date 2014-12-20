DIR_DIST = 'dist'
DIR_STAGE = '_stage'
DIR_SRC = 'src'

module.exports =
  name: '<%= _.slugify(projectName) %>'
  path:
    dist:
      root   : DIR_DIST
      scripts: DIR_DIST + '/scripts'
      styles : DIR_DIST + '/styles'
    stage:
      root   : DIR_STAGE
      scripts: DIR_STAGE + '/scripts'
      styles : DIR_STAGE + '/styles'
    src:
      root  : DIR_SRC
      html  : DIR_SRC + '/html'<% if(jsOption === 'coffeescript'){ %>
      coffee: DIR_SRC + '/coffee' <% } %>
      css   : <% if(cssOption === 'css'){ %>DIR_DIST + '/styles'<% }else{ %>DIR_SRC + '/<%= cssOption %>'<% } %>
  host: 'localhost'
  ports:
    server    : 9000
    livereload: 35729
  autoprefixer_browsers: [
    'ie >= 10'
    'ff >= 30'
    'chrome >= 34'
    'safari >= 7'
    'ios >= 7'
    'android >= 4.4'
  ]
