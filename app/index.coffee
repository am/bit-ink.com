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
    @setup.apply @express
    @server.apply @express

  setup: ->
    @set 'views', "#{__dirname}/views"
    @set 'view engine', 'jade'
    @use new stylusMiddleware
    @use '/css/vendor/prismjs', express.static "#{__dirname}/../node_modules/prismjs/themes"
    @use express.static "#{__dirname}/../public"
    @use logger(if @settings.env is 'development' then 'dev' else 'short')
    @use controllers

  server: ->
    # start server
    @listen config.port, config.ipaddress, =>
      console.log "
        #{ util.dateNow() }: Node server started on #{ config.ipaddress }:#{ config.port }...
      "

module.exports = App
