restler = require("restler")
baseUrl = "http://odata.netflix.com/Catalog/"

# Helper function to handle all the OData requests
build_result = (resource, query = "", callback) ->
  url = baseUrl + resource + "?$format=json" + query.replace(/\s/g, '%20')
  restler.get(url)
    .on "complete", (data) ->
      callback(data.d)

# Given a year, return the top 100 rated movies from Netflix
exports.findByTopRated = (year = null, callback) ->
  query = "&$filter=Type eq 'Movie' and Instant/Available eq true"
  if year
    query += " and ReleaseYear eq #{year}"
  query += "&$orderby=AverageRating desc&$top=100"
  build_result "Titles", query, callback
