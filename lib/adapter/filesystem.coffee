_ = require 'underscore'
fs = require 'fs'
probe = require 'node-ffprobe'

Track = require '../track'

class FileSystemAdapter
  tracks: []
  tracksDir: 'media'

  constructor: (dir) ->
    @tracksDir = dir

  loadTracks: (cb) ->
    fs.readdir @tracksDir, (err, files) =>
      throw 'Error reading tracks from filesystem' if err

      @tracks = files
      console.log 'Filesystem adapter initialized'
      cb()

  next: (cb) ->
    track = @tracks[_.random 0, @tracks.length-1]
    file = "#{@tracksDir}/#{track}"

    probe file, (err, data) =>
      throw 'Error reading track info' if err

      rate = data.format.bit_rate
      stream = fs.createReadStream file
      cb new Track stream, "#{data.metadata.artist} - #{data.metadata.title}", rate

module.exports = FileSystemAdapter
