fs = require "fs"
exports = module.exports = {}
exports.scan = (dir, depth, done) ->
  depth--
  results = []
  fs.readdir dir, (err, list)->
#    console.log(list)
    return done(err) if err
    i = 0
    next = ()->
      file = list[i++]
#      console.log(file)
#      console.log 'uddddd'
      return done(null, results) if !file
      file = dir + '/' + file
#      console.log(file)
#      console.log(depth)
      fs.stat file, (err, stat) ->
        if stat and stat.isDirectory()
          if depth isnt 0
           if depth is -1
             ndepth = 0
            else
              ndepth = if (depth > 1) then (depth - 1) else 1
#            console.log depth
#            console.log ndepth
#            console.log 'nd'
            exports.scan file, ndepth, (err,res)->
#              console.log("#{results}+++")
              results = results.concat res
              next()
          else
            next()
        else
#          console.log("#{depth}----")
#          console.log("#{file}----")
#          console.log(stat.isDirectory())
          results.push file
          next()
    next()
#exports.scan "../.test_files", 2 ,(err,flist)->
#  console.log(flist)