Track = require '../models/track.coffee'

module.exports = (app) ->
  track = new Track title: 'Test', length: 360
  track.save()

  app.get '/', (req, res) ->

    res.render 'index',
      track: app.radio.currentTrack

