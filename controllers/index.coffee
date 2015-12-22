Track = require '../models/track.coffee'

module.exports = (app) ->
  track = new Track title: 'Test', length: 360
  track.save()

  app.get '/', (req, res) ->
    res.render 'index',
      track: JSON.stringify app.radio.currentTrack.export()
      history: JSON.stringify app.radio.history.export()
      configJSON: JSON.stringify app.get('config')
      config: app.get('config')
      env: app.get('env')


