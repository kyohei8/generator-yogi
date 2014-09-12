"use strict"
util = require("util")
fs = require("fs")
path = require("path")
yeoman = require("yeoman-generator")
yosay = require("yosay")
exec = require('child_process').exec
chalk = require 'chalk'

_distDir = 'stage'

YogiHerokuGenerator = module.exports = (args, options, config) ->
  yeoman.generators.Base.apply @, arguments

util.inherits YogiHerokuGenerator, yeoman.generators.Base

# prompt
YogiHerokuGenerator::askFor = ->
  done = @async()

  prompt = [
    {
      name   : "appName"
      message: "What would you like to name your App?"
    }
    {
      name: "useBasicAuth"
      type: "confirm"
      message: "Using Basic Auth?"
    }
  ]
  @prompt(prompt, ((props) ->
    @appName = this._.slugify(props.appName) #if @appName is ''
    @useBA = props.useBasicAuth
    done()
  ).bind @)

YogiHerokuGenerator::askForBasicAuthSetting = ->
  done = @async()
  unless @useBA
    done()
    return

  prompt = [
    {
      name   : "name"
      message: "input Basic Auth name:"
    }
    {
      name: "pass"
      message: "input Basic Auth password:"
    }
  ]
  @prompt(prompt, ((props) ->
    @ba =
      name:props.name
      pass:props.pass
    done()
  ).bind @)

# Check toolbelt has been installed
YogiHerokuGenerator::checkInstallation = ->
  return if @abort
  done = @async()
  exec "heroku --version", ((err) ->
    if err
      @log.error "You don't have the Heroku Toolbelt installed. " + "Grab it from https://toolbelt.heroku.com/"
      @abort = true
    done()
  ).bind(this)

# git init
YogiHerokuGenerator::gitInit = ->
  return if @abort
  done = @async()
  @log chalk.bold("\nInitializing deployment repo")

  if fs.existsSync _distDir
    @abort = true
    @log.error "directory '#{_distDir}' is already exists."
    return

  @mkdir _distDir
  child = exec("git init", {cwd: _distDir}, ((err, stdout, stderr) ->
    done()
  ).bind(this))

  child.stdout.on "data", (data) ->
    console.log data.toString()


# create heroku app
YogiHerokuGenerator::createHerokuApp = ->
  return if @abort
  done = @async()
  @log chalk.bold "Creating heroku app"
  cmd = "heroku apps:create #{@appName}"
  child = exec(cmd, {cwd: _distDir}, ((err, stdout, stderr) ->
    if (err)
      @abort = true;
      @log.error(err);
    else
      @log('stdout: ' + stdout);

    done()
  ).bind(this))

  child.stdout.on 'data', ((data) ->
    output = data.toString()
    @log output
  ).bind(this)

# copy files
YogiHerokuGenerator::copyFiles = () ->
  return if @abort
  done = @async()
  @log chalk.bold 'Creating application files...'
  @copy 'package.json', "#{_distDir}/package.json"
  @copy 'Procfile', "#{_distDir}/Procfile"
  @copy '.gitignore', "#{_distDir}/.gitignore"
  @copy 'server.js', "#{_distDir}/server.js"

  @conflicter.resolve (err) ->
    if err
      @abort = true
      @log.error(err)
    else
      done()

# build
YogiHerokuGenerator::build = () ->
  # TODO 'gulp build'を呼び出す
  return if @abort
  done = @async()
  @log chalk.bold 'Build files...'
  # 仮でcpする
  cmd = "cp -r dist/* #{_distDir}"
  child = exec(cmd, ((err, stdout, stderr) ->
    if (err)
      @abort = true;
      @log.error(err);
    @log chalk.bold 'Build done!'
    done()
  ).bind(this))

  child.stdout.on 'data', ((data) ->
    @log data.toString()
  ).bind(this)

# git commit
YogiHerokuGenerator::gitCommit = () ->
  return if @abort
  done = @async()

  @log chalk.bold 'Adding files for initial commit'
  cmd = 'git add -A && git commit -m "Initial commit"'
  child = exec(cmd, {cwd: _distDir}, ((err, stdout, stderr) ->
    if stdout.search('nothing to commit') >= 0
      @log 'Re-pushing the existing "' + _distDir + '" build...'
    else if err
      @log.error err
    else
      @log chalk.green 'Done, without errors.'

    done()
  ).bind(this))

  child.stdout.on('data',((data) ->
    @log(data.toString());
  ).bind(this))

# git push
YogiHerokuGenerator::gitPush = () ->
  return if @abort
  done = @async()

  @log(chalk.bold("\nUploading your initial application code.\n This may take "+chalk.cyan('several minutes')+" depending on your connection speed..."));

  cmd = 'git push -f heroku master'
  child = exec(cmd, { cwd: _distDir }, ((err, stdout, stderr) ->
    if err
      @log.error(err);
    else
      @log chalk.green '\nYour app should now be live.\n'
    done()
  ).bind(this))

# open
YogiHerokuGenerator::herokuOpen = () ->
  return if @abort
  done = @async()

  cmd = 'heroku open'
  child = exec(cmd, { cwd: _distDir }, ((err, stdout, stderr) ->
    if err
      @log.error(err)
    done()
  ).bind(this))

# deploy (first time or second time)
