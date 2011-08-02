$ = jQuery

module.exports = App =
  init: ->
    titlesTmpl = require('index')

    $('#controls').delegate "form", "submit", (e) ->

      e.preventDefault()

      form = $(this)
      path = form.attr('action')
      query = "?#{form.serialize()}"

      $.getJSON path + '.json' + query, (titles) ->
        $("#main").html(titlesTmpl(titles: titles))
        history.pushState(titles, "", path + query);

