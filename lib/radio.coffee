_ = require 'underscore'

Listener = require './listener'
Player = require './player'

class Radio
  listeners: []
  listenersCount: 0
  player: undefined

  constructor: ->
    @player = new Player()

    @player.on 'ready', @onReady
    @player.on 'data', @onRead
    @player.on 'end', => console.log arguments

    console.log 'Radio initialized'

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

  onReady: =>
    @player.nextTrack()

  onRead: (data) =>
    for listener in @listeners
      listener.send data

module.exports = new Radio
