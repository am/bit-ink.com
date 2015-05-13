express = require 'express'
app = express()
stylus = require 'stylus'
nib = require 'nib'
mds = require 'markdown-serve'
path = require 'path'
logger = require 'morgan'

class App

  ipaddress: null
  port: null

  constructor: ->
    @config()
    @setupTerminationHandlers()
    @initializeServer()

  config: ->
    @ipaddress = process.env.OPENSHIFT_NODEJS_IP
    @port = process.env.OPENSHIFT_NODEJS_PORT || 9000
    @ipaddress = '127.0.0.1' if @ipaddress is undefined

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
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use mds.middleware(
      rootDirectory: path.resolve __dirname, 'data'
      view: 'markdown'
    )
    app.use stylus.middleware(
      src: __dirname + '/stylus'
      dest: __dirname + '/public/css'
      compile: @compileStylus
    )
    app.use express.static __dirname + '/public'
    app.use logger 'dev'

    app.get '/', (req, res) ->
      res.render 'index'

  start: ->
    app.listen @port, @ipaddress, =>
      console.log "#{@dateNow()}: Node server started on #{@ipaddress}:#{@port}..."

  dateNow: ->
    Date Date.now()

module.exports = App
