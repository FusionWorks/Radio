_ = require 'underscore'

class History
  tracks: []

  add: (track) ->
    @tracks.pop() if @tracks.length is 6
    @tracks.push track

  export: ->
    _.invoke @tracks, 'export'

module.exports = History
