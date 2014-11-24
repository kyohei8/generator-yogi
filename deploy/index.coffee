"use strict"
util = require("util")
fs = require("fs")
path = require("path")
yeoman = require("yeoman-generator")
yosay = require("yosay")
exec = require('child_process').exec
chalk = require 'chalk'

_distDir = '_stage'

YogiHerokuGenerator = module.exports = (args, options, config) ->
  yeoman.generators.Base.apply @, arguments

util.inherits YogiHerokuGenerator, yeoman.generators.Base

# prompt
YogiHerokuGenerator::askFor = ->
  done = @async()

  prompt = [
    {
      name   : 'commitComment'
      message: 'enter commit comment'
      default: 'update'
    }
  ]
  @prompt(prompt, ((props) ->
    @commitComment = props.commitComment
    done()
  ).bind @)

# 作成したファイルをstageディレクトリへ移行
YogiHerokuGenerator::build = () ->
  return if @abort
  done = @async()
  @log chalk.bold 'Build files...'
  # 'gulp stage'を呼び出す
  cmd = "gulp stage"
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
  cmd = 'git add -A && git commit -m "' + @commitComment + '"'
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
      @log.error(err)
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
