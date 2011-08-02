express = require "express"
Resource = require "express-resource"
stitch = require "stitch"
jade = require "jade"
fs = require "fs"
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
  res.redirect "/titles"

app.resource "titles", require("./app/controllers/titles_controller")

# Compile views and make them available via stitch
stitch.compilers.jade = (module, filename) ->
  content = "module.exports = #{jade.compile(fs.readFileSync filename, 'utf8')};"
  module._compile content, filename

package = stitch.createPackage
  paths: [ __dirname + '/app/views/titles', __dirname + '/public/javascripts' ]
  dependencies: [ __dirname + '/public/vendor/jquery-1.6.2.js' ]


app.get('/javascripts/lib.js', package.createServer());

port = process.env.PORT || 3000
app.listen(port)
