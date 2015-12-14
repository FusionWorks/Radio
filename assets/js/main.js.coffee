#= require jquery/dist/jquery
#= require foundation-sites/dist/foundation
#= require jquery-backstretch/src/jquery.backstretch
#= require socket.io-client/socket.io
#= require buzz/dist/buzz.js
#= require player

$ ->
  $(document).foundation()

  $('.off-canvas-content').backstretch [
    'http://dl.dropbox.com/u/515046/www/outside.jpg'
    'http://dl.dropbox.com/u/515046/www/garfield-interior.jpg'
    'http://dl.dropbox.com/u/515046/www/cheers.jpg'
  ],
    duration: 3000
    fade: 750

  volume = $('.volume-btn')
  volume.on 'click', ->
    $(this).addClass 'active'

  $('body').click (e) ->
    if !($.contains(volume[0], e.target) or volume.is(e.target) or $('.js-callback-control').is(e.target))
      volume.removeClass 'active'

  socket = io 'http://localhost:8000'
  socket.on 'track', (track) ->
    console.log track

  player = new Player

