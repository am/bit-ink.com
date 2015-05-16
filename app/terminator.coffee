util = require './util'

module.exports = ->

  terminate = (sig) ->
    if typeof sig is 'string'
      console.log "#{util.dateNow()}: Received #{sig} - terminating app..."
      process.exit 1
    console.log "#{util.dateNow()}: Node server stopped."

  process.on 'exit', => terminate()

  signals = ['SIGHUP', 'SIGINT', 'SIGQUIT', 'SIGILL', 'SIGTRAP', 'SIGABRT',
    'SIGBUS', 'SIGFPE', 'SIGUSR1', 'SIGSEGV', 'SIGUSR2', 'SIGTERM'
  ]
  for signal in signals
    process.on signal, => terminate signal
