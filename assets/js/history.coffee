class History
  tracks: []
  current: undefined
  socket: undefined
  el: $("#playlist")
  tplHistory: _.template '<div class="song-wrap"><div class="time"><%= moment(startTime).format("HH:mm") %></div><div class="name"><%= name %></div></div>'
  tplCurrent: _.template '<div class="song-wrap current-song"><div class="time"><i class="fi-play"></i></div><div class="name"><%= name %></div></div>'

  constructor: (opts) ->
    @addTrack track for track in opts.tracks
    @socket = opts.socket

    @socket.on 'track', @addTrack

  addTrack: (track) =>
    if @tracks.length is 6
      @el.find("#playlist .song-wrap:last").remove()
      @tracks.pop()

    if @current
      @tracks.push @current
      @el.find("#history").prepend @tplHistory @current

    @el.find("#current").html @tplCurrent track
    @current = track


