class window.Player
  isPlaying: false
  url: 'http://localhost:3015/stream'
  player: undefined
  volume: 80

  constructor: ->
    @player = new buzz.sound @url,
      autoplay: true

    volume = $('.volume-btn')
    volume.on 'click', ->
      $(this).addClass 'active'

    $('body').click (e) ->
      if !($.contains(volume[0], e.target) or volume.is(e.target) or $('.js-callback-control').is(e.target))
        volume.removeClass 'active'

    $("#volume-slider").on 'moved.zf.slider', =>
      @volume = parseInt $("#actual-volume").val()

      $("#volume").val @volume
      @player.setVolume @volume

    @isPlaying = true

    $("#play").click =>
      unless @isPlaying
        @_toggleState()
        @player.addSource @url
        @player.play()

    $("#stop").click =>
      if @isPlaying
        @_toggleState()
        @player.stop()

  _toggleState: ->
    @isPlaying = ! @isPlaying
    $("#play i").toggleClass 'active'
    $("#stop i").toggleClass 'stop'
