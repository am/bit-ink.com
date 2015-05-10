express = require 'express'
app = express()
stylus = require 'stylus'
nib = require 'nib'
mds = require 'markdown-serve'
path = require 'path'
logger = require 'morgan'

compileStylus = (str, path) ->
  stylus(str)
    .set('filename', path)
    .set('compress', true)
    .set('include css', true)
    .use(nib())
    .import('nib')

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use mds.middleware(
  rootDirectory: path.resolve __dirname, 'data'
  view: 'markdown'
)

app.use stylus.middleware(
  src: __dirname + '/stylus'
  dest: __dirname + '/public/css'
  compile: compileStylus
)
app.use express.static __dirname + '/public'
app.use logger 'dev'

# routes
app.get '/', (req, res) ->
  res.render 'index'

app.get '/cv', (req, res) ->
  res.render 'cv'

# server
server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port

  console.log "Started server on http://#{host}:#{port}"
