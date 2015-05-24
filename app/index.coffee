express = require 'express'
logger = require 'morgan'

util = require './util'
config = require './config'
stylusMiddleware = require './middleware/stylus'
controllers = require './controllers'

class App
  express: null

  constructor: () ->
    @express = express()
      .set('views', "#{__dirname}/views")
      .set('view engine', 'jade')
      .use(new stylusMiddleware)
      .use(express.static "#{__dirname}/../public")
      .use(logger 'dev')
      .use(controllers)

    # start server
    @express.listen config.port, config.ipaddress, =>
      console.log "
        #{ util.dateNow() }: Node server started on #{ config.ipaddress }:#{ config.port }...
      "

module.exports = App
