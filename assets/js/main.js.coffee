#= require jquery/dist/jquery
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

  volume = $('.volume-btn')
  volume.on 'click', ->
    $(this).addClass 'active'

  $('body').click (e) ->
    if !($.contains(volume[0], e.target) or volume.is(e.target) or $('.js-callback-control').is(e.target))
      volume.removeClass 'active'

  socket = io 'http://localhost:3014'
  socket.on 'track', (track) ->
    $(".current-song .name").html track.name
    console.log track

  player = new Player

