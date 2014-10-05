global.DIR_DIST = 'dist'
global.DIR_STAGE = 'stage'
global.DIR_SRC = 'src'

global.config =
  name: '<%= _.slugify(projectName) %>'
  path:
    dist:
      root   : global.DIR_DIST
      scripts: global.DIR_DIST + '/scripts'
      styles : global.DIR_DIST + '/styles'
    stage:
      root   : global.DIR_STAGE
      scripts: global.DIR_STAGE + '/scripts'
      styles : global.DIR_STAGE + '/styles'
    src:
      root  : global.DIR_SRC<% if(jsOption === 'coffeescript'){ %>
      coffee: global.DIR_SRC + '/coffee' <% } %>
      css   : <% if(cssOption === 'css'){ %>global.DIR_DIST + '/styles'<% }else{ %>global.DIR_SRC + '/<%= cssOption %>'<% } %>
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
