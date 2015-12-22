define [
  'cs!./player'
  'cs!./history'
  'jquery'
  'underscore'
  'io'
  'cs!../ui'
], (Player, History, $, _, io, ui) ->
  class Radio
    constructor: ->
      $(document).foundation()

      initialImage = _.random 1, 131
      $('.off-canvas-content').backstretch "images/bg/img-#{initialImage}.jpg",
        fade: 750
        duration: 600000

      bs = $('.off-canvas-content').data 'backstretch'

      for i in [1..131] when i isnt initialImage
        bs.images.push "images/bg/img-#{i}.jpg"

      socket = io "http://#{opts.config.hostname}:#{opts.config.ws_port}"
      socket.on 'track', (track) ->
        $(".current-song .name").html track.name
        $('.off-canvas-content').backstretch 'next'

      player = new Player
        socket: socket
        currentTrack: window.opts.track
        streamingUrl: "http://#{opts.config.hostname}:#{opts.config.http_port}/#{opts.config.streaming_url}"

      history = new History
        tracks: window.opts.history
        socket: socket
