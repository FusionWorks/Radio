class window.Player
  isPlaying: false
  url: 'http://localhost:3015/stream'
  player: undefined
  volume: 80
  socket: undefined
  step: undefined

  constructor: (opts) ->
    @socket = opts.socket
    @player = new buzz.sound @url,
      autoplay: true


    $(".media-buttons").slideToggle 500, =>
      $(".track").width("#{@elapsed}px").fadeIn 500

    @trackWrapperWidth = $(".track-wrapper").width()
    @step = opts.currentTrack.duration / @trackWrapperWidth
    @elapsed = opts.currentTrack.elapsed / @step

#    @player.bind 'loadeddata', ->
#      debugger

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

    @socket.on 'track', (track) =>
      $(".track").width "0%"
      @step = track.duration / @trackWrapperWidth
      @elapsed = 0
      clearInterval @interval
      @interval = setInterval @_onTick, @step * 1000

    @interval = setInterval @_onTick, @step * 1000

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
    $(".track").fadeToggle 500

  _onTick: =>
    @elapsed++
    $(".track").width "#{@elapsed}px"
