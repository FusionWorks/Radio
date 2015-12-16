_ = require 'underscore'

stream = require 'stream'
Throttle = require 'throttle'

class Track extends stream.Writable
  inputStream: null
  name: null
  duration: null
  rate: null
  elapsed: 0

  _write: (data, encoding, cb) ->
    @_chunk = data
    @emit 'data', data
    cb()

  constructor: (input, name, duration, rate) ->
    super

    @inputStream = input
    @name = name
    @duration = duration
    @rate = rate

    @inputStream.on 'end', =>
      @emit 'end'

  play: ->
    throttle = new Throttle @rate / 8
    @inputStream.pipe(throttle).pipe(@)

    setInterval =>
      @elapsed++
    , 1000

  export: ->
    name: @name
    duration: @duration
    elapsed: @elapsed

module.exports = Track
