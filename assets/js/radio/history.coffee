define ['jquery', 'underscore', 'moment'], ($, _, moment) ->
  class History
    tracks: []
    socket: undefined
    el: $("#playlist")
    tplHistory: _.template '<div class="song-wrap"><div class="time"><%= time %></div><div class="name"><%= name %></div></div>'
    tplCurrent: _.template '<div class="song-wrap current-song"><div class="time"><i class="fi-play"></i></div><div class="name"><%= name %></div></div>'

    constructor: (opts) ->
      @addTrack track for track in opts.tracks
      @socket = opts.socket

      @socket.on 'track', @addTrack

    addTrack: (track) =>
      if @tracks.length is 6
        @el.find("#history .song-wrap:last").remove()
        @tracks.shift()

      if @tracks.length
        shiftedTrack = _.last @tracks
        @el.find("#history").prepend @tplHistory
          name: shiftedTrack.name
          time: moment(shiftedTrack.startTime).format "HH:mm"

      @tracks.push track
      @el.find("#current").html @tplCurrent track


