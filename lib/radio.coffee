_ = require 'underscore'

Listener = require './listener'
Player = require './track'
History = require './history'

class Radio
  listeners: []
  listenersCount: 0
  adapter: undefined
  socket: undefined
  currentTrack: undefined
  history: undefined

  constructor: (adapter, socket) ->
    @adapter = adapter
    @socket = socket
    @history = new History

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
      @history.add track

      @currentTrack.on 'data', @onRead
      @currentTrack.on 'end', @onEnd

      console.log "Playing track #{track.name}"

      @socket.emit 'track', track.export()
      track.play()

  onRead: (data) =>
    for listener in @listeners
      listener.send data

  onEnd: =>
    setTimeout =>
      @currentTrack = null
      delete @currentTrack
      @_next()
    , 1000

module.exports = Radio
