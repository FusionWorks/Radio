_ = require 'underscore'

class Listener
  id: undefined
  response: undefined

  constructor: (response) ->
    @id = _.uniqueId()
    @response = response
    @_writeHead()

  send: (data) ->
    @response.write data

  _writeHead: ->
    @response.writeHead 200,
      'Content-Type': 'audio/mpeg'
      'Connection': 'close'
      'Transfer-Encoding': 'identity'

module.exports = Listener
