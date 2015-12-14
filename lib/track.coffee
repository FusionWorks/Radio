_ = require 'underscore'

stream = require 'stream'
Throttle = require 'throttle'

class Track extends stream.Writable
  inputStream: null
  name: null
  rate: null

  _write: (data, encoding, cb) ->
    return @emit 'end' unless data

    @_chunk = data
    @emit 'data', data
    cb()

  constructor: (input, name, rate) ->
    super

    @inputStream = input
    @name = name
    @rate = rate

  play: ->
    throttle = new Throttle @rate / 8
    @inputStream.pipe(throttle).pipe(@)

module.exports = Track
