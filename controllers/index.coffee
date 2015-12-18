Track = require '../models/track.coffee'

module.exports = (app) ->
  track = new Track title: 'Test', length: 360
  track.save()

  app.get '/', (req, res) ->
    console.log app.radio.history.export()
    res.render 'index',
      track: JSON.stringify app.radio.currentTrack.export()
      history: JSON.stringify app.radio.history.export()

