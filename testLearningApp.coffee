tags = require "./lib/tags.coffee"
search = require "./lib/search.coffee"

defaults = {
  path : ".",
  query : "",
  depth : 2
}

replacements = {
  p: "path",
  q: "query",
  d: "depth",
  h: "help"
}
tags = tags.parse(process.argv, defaults, replacements)
if tags.help
  console.log("Usage: ./testLearningApp.coffee -q=query [-d=depth] [-p=path]")
else
  search.scan tags.path, tags.depth, (err,files) ->
    search.match(tags.query,files)