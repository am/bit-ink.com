express = require 'express'

util = require './util'
config = require './config'

require('./terminator')()

module.exports = ->
  @serverConfig =
    ipaddress: process.env.OPENSHIFT_NODEJS_IP
    port: process.env.OPENSHIFT_NODEJS_PORT or 9000

  @express = express()

  # configure app
  config.apply @express

  # controllers
  @express.use require './controllers'

  # start server
  @express.listen @serverConfig.port, @serverConfig.ipaddress, =>
    console.log "
      #{ util.dateNow() }: Node server started on #{ @serverConfig.ipaddress }:#{ @serverConfig.port }...
    "
