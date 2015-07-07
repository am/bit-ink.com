express = require 'express'
logger = require 'morgan'

util = require './util'
config = require './config'
StylusMiddleware = require './middleware/stylus'
controllers = require './controllers'

class App
  express: null

  constructor: ->
    @express = express()

  setup: ->
    @express.locals.pretty = on
    @express.set 'views', "#{__dirname}/views"
    @express.set 'view engine', 'jade'
    @express.use new StylusMiddleware
    @express.use '/components', express.static "#{__dirname}/../bower_components"
    @express.use express.static "#{__dirname}/../public"
    @express.use logger(if @express.settings.env is 'development' then 'dev' else 'short')
    @express.use controllers

  server: ->
    @express.listen config.port, config.ipaddress, @serverLog

  serverLog: ->
    => console.log "
      #{ util.dateNow() }: Node server started on #{ config.ipaddress }:#{ config.port }...
    "

module.exports = App
