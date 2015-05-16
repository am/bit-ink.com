express = require 'express'
marked = require 'marked'
jade = require 'jade'
path = require 'path'
Promise = require 'bluebird'
fs = Promise.promisifyAll require 'fs'

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

  # routes
  @express.get '/', (req, res, next) ->
    res.render 'index'

  @express.get '/cv/:page?', (req, res, next) ->
    page = req.params.page or 'index'
    md = path.join __dirname, "../markdown/#{ page }.md"
    fs.readFileAsync(md).then (val) ->
      options = markdown: marked val.toString()
      html = jade.renderFile path.join(__dirname, 'views/markdown.jade'), options
      res.send html

  # start server
  @express.listen @serverConfig.port, @serverConfig.ipaddress, =>
    console.log "
      #{ util.dateNow() }: Node server started on #{ @serverConfig.ipaddress }:#{ @serverConfig.port }...
    "
