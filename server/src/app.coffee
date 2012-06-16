###
# 
# Main application file for 500ties.com
#
# Auckland Startup weekend
# Mariusz Nowostawski 
#
###


# configuration from package.json
fs = require 'fs'
conf = JSON.parse fs.readFileSync './package.json'


# Module dependencies.
express = require 'express'
MongoStore = require('connect-mongo') express
stylus = require 'stylus'

app = express.createServer()

mongoose = require 'mongoose'
mongooseTypes = require 'mongoose-types'
mongooseTypes.loadTypes mongoose, 'email'
db = mongoose.connect 'mongodb://localhost/ties500'
mongooseAuth = require 'mongoose-auth'



# Exporting the app and dependencies
app.conf = conf
app.mongoose = mongoose
app.mongooseAuth = mongooseAuth


# Authentication and User management
app.users = require('./models/users')(app)

# Export the application
module.exports = app



# Configuration

app.configure( () ->
  app.set 'views', (__dirname + '/views')
  app.set 'view engine', 'jade'
  app.set 'view options', {layout: false}
  app.dynamicHelpers
    session: (req, res) ->
        req.session
    messages: require 'express-messages-bootstrap'
  app.use express.favicon __dirname + '/public/img/favicon.ico'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  # MemoryStore app.use express.session secret: 'your secret here'
  app.use express.session
    secret: 'super secret string comes here'
    store: new MongoStore
        db: 'diveclub-sessions'
  app.use stylus.middleware src: __dirname + '/public', compress: true
  #  app.use everyauth.middleware()
  app.use mongooseAuth.middleware()
  app.use app.router
  app.use express.static (__dirname + '/public'))

app.configure 'development', () ->
  app.use express.errorHandler dumpExceptions: true, showStack: true


app.configure 'production', () ->
  app.use express.errorHandler()

mongooseAuth.helpExpress(app)


# Routes
require('./routes')(app)


