express = require "express"
Resource = require "express-resource"
app = module.exports = express.createServer()

# Configuration
app.configure ->
  app.set "views", __dirname + "/app/views"
  app.set "view engine", 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler
    dumbExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()


# Routes
app.get "/", (req, res) ->
  res.render "index", title: "Express"

app.resource "titles", require("./app/controllers/titles_controller")

port = process.env.PORT || 3000
app.listen(port)
