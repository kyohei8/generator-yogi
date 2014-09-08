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

# 上から順に実行される？

YogiHerokuGenerator::askFor = ->
  done = @async()

  prompt = [{
    name   : "appName"
    message: "What would you like to name your App?"
  }]
  @prompt(prompt, ((props) ->
    @appName = this._.slugify(props.appName) #if @appName is ''
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
