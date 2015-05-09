express = require 'express'
app = express()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  res.render 'index', foo: 'bar'

server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port

  console.log "Started server on http://#{host}:#{port}"
