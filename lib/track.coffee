_ = require 'underscore'

stream = require 'stream'
Throttle = require 'throttle'

class Track extends stream.Writable
  inputStream: null
  name: null
  duration: null
  rate: null
  elapsed: 0
  startTime: undefined

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
    @startTime = new Date()

    setInterval =>
      @elapsed++
    , 1000

  export: ->
    name: @name
    duration: @duration
    elapsed: @elapsed
    startTime: @startTime

module.exports = Track
