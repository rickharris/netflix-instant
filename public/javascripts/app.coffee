$ = jQuery

# `App` watches for control form submissions, queries the server for matching
# titles, and then updates the titles list and the URL
module.exports = class App

  constructor: ->

    _.bindAll(this)

    # Get our titles template from Stitch
    @titlesTmpl = require('index')

    # Listen for those form submissions
    $('#controls').delegate "form", "submit", @onFormSubmit

    # Make sure to update our titles list on the browser forward/back event
    window.onpopstate = @onPopState


  update: (titles) ->
    # Replace whatever content is in `#main` with our rendered titles
    $("#main").html(@titlesTmpl(titles: titles))

  onFormSubmit: (event) ->
    event.preventDefault()

    form = $(event.currentTarget)
    @lastPath = window.location.pathname
    @lastQuery = "?#{form.serialize()}"
    @lastQuery = "" if @lastQuery == '?year='

    $.getJSON @lastPath + '.json' + @lastQuery, @onResponse


  onResponse: (titles) ->
    @update titles
    history.pushState titles, "", @lastPath + @lastQuery

  onPopState: (event) ->
    # `onpopstate` is fired on the initial state (page load), when there is no
    # state set, so we only act on subsequent firings, when the state will be
    # set
    @update event.state if event.state
