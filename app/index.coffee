express = require 'express'
util = require './util'
config = require './config'

server =
  ipaddress: process.env.OPENSHIFT_NODEJS_IP
  port: process.env.OPENSHIFT_NODEJS_PORT or 9000

require('./terminator')()

module.exports = ->
  @express = express()

  # configure app
  config.apply @express

  # routes
  @express.get '/', (req, res, next) ->
    res.render 'index'

  # start server
  @express.listen server.port, server.ipaddress, =>
    console.log "
      #{util.dateNow()}: Node server started on #{server.ipaddress}:#{server.port}...
    "
