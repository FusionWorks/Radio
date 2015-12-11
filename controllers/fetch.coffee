request = require 'request'
Track = require '../models/track.coffee'

module.exports = (app) ->
  app.get '/fetch', (req, res) ->
    res.render 'index'

