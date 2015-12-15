Radio = require '../lib/radio'
Adapter = require '../lib/adapter/filesystem'

module.exports = (app) ->
  server = require('http').createServer(app)
  socket = require('socket.io') server
  server.listen 3014

  adapter = new Adapter 'media'
  radio = new Radio adapter, socket
  app.radio = radio

  app.get '/stream', (req, res) ->
    listener = radio.addListener req, res

    req.connection.on 'close', ->
      radio.removeListener listener

