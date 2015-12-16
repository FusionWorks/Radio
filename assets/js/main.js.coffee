#= require jquery/dist/jquery
#= require underscore/underscore
#= require foundation-sites/dist/foundation
#= require jquery-backstretch/src/jquery.backstretch
#= require buzz.js
#= require player

$ ->
  $(document).foundation()

  $('.off-canvas-content').backstretch [
    'images/bg/1.jpg'
  ],
#    duration: 3000
#    fade: 750


  socket = io 'http://localhost:3014'
  socket.on 'track', (track) ->
    $(".current-song .name").html track.name
    console.log track

  player = new Player
    socket: socket
    currentTrack:
      elapsed: window.opts.elapsed
      duration: window.opts.duration

