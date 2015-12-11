_ = require 'underscore'
fs = require 'fs'
stream = require 'stream'
probe = require 'node-ffprobe'
Throttle = require 'throttle'

class Player extends stream.Writable
  tracks: []
  tracksDir: 'media'

  _write: (data, encoding, cb) ->
    @_chunk = data
    @emit 'data', data
    cb()

  constructor: ->
    super

    @_loadTracks =>
      @emit 'ready'
      console.log "Player initialized. Total tracks: #{@tracks.length}"

  nextTrack: ->
    track = @tracks[_.random 0, @tracks.length-1]
    file = "#{@tracksDir}/#{track}"

    probe file, (err, data) =>
      rate = data.format.bit_rate
      stream = fs.createReadStream file
      throttle = new Throttle rate * 10

      stream.pipe(throttle).pipe(@)

  _loadTracks: (cb) ->
    fs.readdir @tracksDir, (err, files) =>
      throw 'Error initializing player' if err

      @tracks = files
      cb()

module.exports = Player
