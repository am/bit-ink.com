express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
mds = require 'markdown-serve'
path = require 'path'
logger = require 'morgan'

class App
  server: null
  ipaddress: null
  port: null

  constructor: ->
    @config()
    @setupTerminationHandlers()
    @initializeServer()

  config: ->
    @ipaddress = process.env.OPENSHIFT_NODEJS_IP
    @port = process.env.OPENSHIFT_NODEJS_PORT || 9000

  terminator: (sig) ->
    if typeof sig is 'string'
      console.log "#{@dateNow()}: Received #{sig} - terminating app..."
      process.exit 1
    console.log "#{@dateNow()}: Node server stopped."

  setupTerminationHandlers: ->
    process.on 'exit', => @terminator()

    signals = ['SIGHUP', 'SIGINT', 'SIGQUIT', 'SIGILL', 'SIGTRAP', 'SIGABRT',
      'SIGBUS', 'SIGFPE', 'SIGUSR1', 'SIGSEGV', 'SIGUSR2', 'SIGTERM'
      ]
    for signal in signals
      process.on signal, => @terminator signal

  compileStylus: (str, path) ->
    stylus(str)
      .set('filename', path)
      .set('compress', true)
      .set('include css', true)
      .use(nib())
      .import('nib')

  initializeServer: ->
    @server = express()
    @server.set 'views', __dirname + '/views'
    @server.set 'view engine', 'jade'
    @server.use mds.middleware(
      rootDirectory: path.resolve __dirname, 'data'
      view: 'markdown'
    )
    @server.use stylus.middleware(
      src: __dirname + '/stylus'
      dest: __dirname + '/public/css'
      compile: @compileStylus
    )
    @server.use express.static __dirname + '/public'
    @server.use logger 'dev'

    @server.get '/', (req, res) ->
      res.render 'index'

  start: ->
    @server.listen @port, @ipaddress, =>
      console.log "#{@dateNow()}: Node server started on #{@ipaddress}:#{@port}..."

  dateNow: ->
    Date Date.now()

module.exports = App
