require('coffee-script/register')
var config = require('./env.coffee')

if(config.env){
  require('./'+config.env+'.gulpfile.coffee')
}
else{
  require('./gulpfile.coffee')
}