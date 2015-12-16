#= require jquery/dist/jquery
#= require underscore/underscore
#= require foundation-sites/dist/foundation
#= require jquery-backstretch/src/jquery.backstretch
#= require buzz.js
#= require player

$ ->
  $(document).foundation()

  initialImage = _.random 1, 131
  $('.off-canvas-content').backstretch "images/bg/img-#{initialImage}.jpg",
    fade: 750
    duration: 600000

  bs = $('.off-canvas-content').data 'backstretch'

  for i in [1..131] when i isnt initialImage
    bs.images.push "images/bg/img-#{i}.jpg"

  socket = io 'http://localhost:3014'
  socket.on 'track', (track) ->
    $(".current-song .name").html track.name
    $('.off-canvas-content').backstretch 'next'
    console.log track

  player = new Player
    socket: socket
    currentTrack:
      elapsed: window.opts.elapsed
      duration: window.opts.duration

