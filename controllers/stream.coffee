radio = require('../lib/radio')

module.exports = (app) ->
  app.get '/stream', (req, res) ->
    listener = radio.addListener req, res

    req.connection.on 'close', ->
      radio.removeListener listener

