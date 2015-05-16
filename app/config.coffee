express = require 'express'
stylus = require 'stylus'
mds = require 'markdown-serve'
path = require 'path'
logger = require 'morgan'

util = require './util'

module.exports = ->
  @set 'views', "#{__dirname}/views"
  @set 'view engine', 'jade'

  # middleware
  @use mds.middleware(
    rootDirectory: path.resolve __dirname, '../markdown'
    view: 'markdown'
  )

  @use stylus.middleware(
    src: "#{__dirname}/../stylus"
    dest: "#{__dirname}/../public/css"
    compile: util.compileStylus
  )
  @use express.static "#{__dirname}/../public"
  @use logger 'dev'
