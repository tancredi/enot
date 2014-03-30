var express = require('express'),
    color = require('cli-color'),
    logger = require('./logger');

var app = express(),
    port = process.env.PORT || 3000;

app.use(logger);

app.use(express.static('./www'));

app.listen(port);
console.log(color.green('Listening on port ' + port + '...'));