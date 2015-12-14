class window.Player
  isPlaying: false
  url: 'http://localhost:3000/stream'
  player: undefined

  constructor: ->
    @player = new buzz.sound @url,
      autoplay: true

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
