Title = require "../models/title"

exports.index = (req, res) ->
  Title.findByTopRated req.query.year, (data) ->
    res.render "titles/index.jade",
      title: "Netflix Watch Instantly Browser"
      titles: data
      year: req.query.year
