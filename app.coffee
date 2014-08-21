express = require 'express'
app = new express()

app.set 'view engine','jade'
app.engine 'jade', require('jade').__express
app.set 'views',"#{__dirname}/view"
##consolo.log "#{__dirname}/view"
#console.log 'a'
##console.log "#{__dirname}/view"
#app.set 'view engine','jade'

app.use express.static __dirname + '/public'
#app.use express.static __dirname + '/view'
#console.log 'b'
console.log 'c'
#app.engine()
app.get '/', (req,res) ->
#  res.send('hello world');
  foo =5
  res.render('testView',{foo:foo})
  console.log 's'

app.listen(3000);
console.log 'listen on 3000'
