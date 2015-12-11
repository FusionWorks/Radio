express = require 'express'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
fs = require 'fs'
mongoose = require 'mongoose'

paths =
  views: 'views'
  controllers: 'controllers'
  assets: 'assets'

app = express()

# init DB
mongoose.connect 'mongodb://localhost/fw-radio'

# view engine setup
app.set 'views', "./#{paths.views}"
app.set 'view engine', 'jade'

# assets management
app.use require('connect-assets')
  paths: ("#{paths.assets}/#{dir}" for dir in ['js', 'css', 'font', 'vendor'])
  fingerprinting: false

# uncomment after placing your favicon in /public
# app.use favicon "#{__dirname}/public/favicon.ico"
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: false
app.use cookieParser()

# load controllers
controllers = fs.readdirSync paths.controllers
for controller in controllers
  require("./#{paths.controllers}/#{controller}") app

# catch 404 and forward to error handler
app.use (req, res, next) ->
    err = new Error 'Not Found'
    err.status = 404
    next err

# error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
    app.use (err, req, res, next) ->
        res.status err.status or 500
        res.render 'error',
            message: err.message,
            error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
        message: err.message,
        error: {}

module.exports = app
