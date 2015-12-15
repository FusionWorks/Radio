_ = require 'underscore'

Listener = require './listener'
Player = require './track'

class Radio
  listeners: []
  listenersCount: 0
  adapter: undefined
  socket: undefined
  currentTrack: undefined

  constructor: (adapter, socket) ->
    @adapter = adapter
    @socket = socket

    @adapter.loadTracks =>
      console.log 'Radio initialized'
      @_next()

  addListener: (req, res) ->
    listener = new Listener res

    @listeners.push listener
    @listenersCount++

    console.log "Listener #{listener.id} connected. Total: #{@listenersCount}"
    listener

  removeListener: (listener) ->
    _.reject @listeners, (l) -> l.id is listener.id
    @listenersCount--

    console.log "Listener #{listener.id} disconnected. Total: #{@listenersCount}"

  _next: ->
    @adapter.next (track) =>
      @currentTrack = track

      @currentTrack.on 'data', @onRead
      @currentTrack.on 'end', @onEnd

      console.log "Playing track #{track.name}"

      @socket.emit 'track', name: track.name
      track.play()

  onRead: (data) =>
    for listener in @listeners
      listener.send data

  onEnd: =>
    @currentTrack = null
    delete @currentTrack
    @_next()

module.exports = Radio