# Module dependencies.

express = require 'express'

routes = require './routes'
budgets = require './routes/budgets'

http = require 'http'
path = require 'path'

app = express()

## all environments
app.set('port', process.env.PORT || 3000)
app.set('views', __dirname + '/views')
app.set('view engine', 'ejs')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(express.cookieParser('your secret here'))
app.use(express.session())
app.use(app.router)
app.use(require('stylus').middleware(__dirname + '/public'))
app.use(express.static(path.join(__dirname, 'public')))

## development only
if 'development' == app.get('env')
  app.use(express.errorHandler())

#app.get('/', budgets.edit)

app.get('/:budget', budgets.edit)
app.get('/:budget/preview', budgets.preview)
app.get('/:budget/pdf', budgets.pdf)

server = http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))

io = require('socket.io').listen(server)

io.sockets.on 'connection', (socket) ->
  socket.emit 'news'
  socket.on 'update', (data) ->
    console.log data
