$ = jQuery

# `App` watches for control form submissions, queries the server for matching
# titles, and then updates the titles list and the URL
module.exports = class App

  constructor: ->

    _.bindAll(this)

    # Cache our inital markup for onpopstate event
    @initialState = $('#main').html()

    # Get our titles template from Stitch
    @titlesTmpl = require('index')

    # Listen for those form submissions
    $('#controls').delegate "form", "submit", @onFormSubmit

    # Make sure to update our titles list on the browser forward/back event
    window.onpopstate = @onPopState


  update: (titles) ->
    # Replace whatever content is in `#main` with our rendered titles
    rendered = if typeof titles == 'string' then titles else @titlesTmpl(titles: titles)
    $("#main").html(rendered)

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
    @update event.state || @initialState
