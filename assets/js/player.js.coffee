class window.Player
  isPlaying: false
  url: ''
  player: undefined
  volume: 80
  socket: undefined
  step: undefined
  trackWrapperWidth: 320

  constructor: (opts) ->
    @socket = opts.socket
    @url = opts.streamingUrl
    @player = new buzz.sound @url,
      autoplay: true

    @step = opts.currentTrack.duration / @trackWrapperWidth
    @elapsed = opts.currentTrack.elapsed / @step

    $(".media-buttons").slideToggle 500, =>
      $(".track").width("#{@elapsed}px").fadeIn 500

      # HTML5 audio component has unexpected behaviour,
      # so we are checking if the stream sah started after 2.5 seconds
      # and force restarting it on fail
      setTimeout =>
        @player.load().play() if @player.getNetworkStateCode() isnt 2
      , 2500

    @player.bind 'loadeddata', ->
      $(".spinner").fadeOut 100, ->
        $("#player-nav").fadeIn 500
        volumeSlider = new Foundation.Slider $("#volume-slider") unless $("#volume-slider").is '[data-slider]'

    volume = $('.volume-btn')

    volume.on "mouseenter", ->
      $(@).addClass 'active'

    volume.on "mouseleave", ->
      $(@).removeClass 'active'

    volume.on 'click', (e) =>
        return true unless e.target.tagName in ['A', 'I']
        $(e.currentTarget).toggleClass 'mute'
        @player.toggleMute()

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
        $("#player-nav").fadeOut 100, ->
          $(".spinner").fadeIn 500
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
