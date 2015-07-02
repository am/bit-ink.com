express = require 'express'
logger = require 'morgan'

util = require './util'
config = require './config'
stylusMiddleware = require './middleware/stylus'
controllers = require './controllers'

class App
  express: null

  constructor: ->
    @express = express()
    @setup()
    @server()

  setup: ->
    @express.set 'views', "#{__dirname}/views"
    @express.set 'view engine', 'jade'
    @express.use new stylusMiddleware
    @express.use '/components', express.static "#{__dirname}/../bower_components"
    @express.use express.static "#{__dirname}/../public"
    @express.use logger(if @express.settings.env is 'development' then 'dev' else 'short')
    @express.use controllers

  server: ->
    # start server
    @express.listen config.port, config.ipaddress, =>
      console.log "
        #{ util.dateNow() }: Node server started on #{ config.ipaddress }:#{ config.port }...
      "

module.exports = App
