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
      if err
        console.log 'Error reading track info'
        @next cb

      rate = data.format.bit_rate
      stream = fs.createReadStream file
      name = data.metadata.title
      name = "#{data.metadata.artist} - #{name}" if data.metadata.artist

      cb new Track stream, name, data.format.duration, rate

module.exports = FileSystemAdapter
