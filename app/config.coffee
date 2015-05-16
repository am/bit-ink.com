express = require 'express'
stylus = require 'stylus'
logger = require 'morgan'

util = require './util'

module.exports = ->
  @set 'views', "#{__dirname}/views"
  @set 'view engine', 'jade'

  # static assets
  @use express.static "#{__dirname}/../public"

  # stylus
  @use stylus.middleware(
    src: "#{__dirname}/../stylus"
    dest: "#{__dirname}/../public/css"
    compile: util.compileStylus
  )

  # logs
  @use logger 'dev'
