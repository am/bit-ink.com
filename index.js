#!/bin/env node

var App, app;

require('coffee-script/register');
App = require('./app');
app = new App;
app.start();
