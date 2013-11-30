var express = require('express');
var mongoose = require('mongoose');
var http = require('http');
var path = require('path');

// database
mongoose.connect('mongodb://localhost');
global.db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));

// express
var app = express();

// other
var budgets = require('./routes/budgets');

// configuration
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(express.cookieParser('your secret here'));
app.use(express.session());
app.use(app.router);
app.use(require('stylus').middleware(__dirname + '/public'));
app.use(express["static"](path.join(__dirname, 'public')));

// development
if ('development' === app.get('env')) {
  app.use(express.errorHandler());
}

// routes
app.get('/', budgets.edit);
app.get('/:id/preview', budgets.preview_html);
app.get('/:id/pdf', budgets.pdf);

// start server
var server = http.createServer(app).listen(app.get('port'), function() {
  return console.log('Express server listening on port ' + app.get('port'));
});

// load models
var Budget = require('./models/budget');

// start socket.io
var io = require('socket.io').listen(server);
io.sockets.on('connection', function(socket) {
  var budget = new Budget;
  budget.save();

  socket.emit('id', { id: budget._id });
  socket.on('update', function(data) {
    budget.name = data.name;
    budget.save();
  });
});
