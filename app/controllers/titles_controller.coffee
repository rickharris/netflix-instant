Title = require "../models/title"

exports.index = (req, res) ->
  Title.findByTopRated null, (data) ->
    res.render "titles/index",
      title: "Netflix Watch Instantly Browser"
      titles: data
