var express = require('express');
var ping = require('./routes/ping');

var app = express();

app.use('/ping', ping);
app.set('port', process.env.PORT || 3000);

var server = app.listen(app.get('port'), function () {
   
});
