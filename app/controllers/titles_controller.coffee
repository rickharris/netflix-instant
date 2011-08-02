Title = require "../models/title"

exports.index = (req, res) ->
  Title.findByTopRated req.query.year, (data) ->
    switch req.format
      when "json" then res.send data
      else
        res.render "titles/index.jade",
          title: "Netflix Watch Instantly Browser"
          titles: data
          year: req.query.year
