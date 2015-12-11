mongoose = require 'mongoose'

TrackSchema = new mongoose.Schema
  title: String
  length: Number
,
  collection: 'Track'

module.exports = mongoose.model 'Track', TrackSchema
