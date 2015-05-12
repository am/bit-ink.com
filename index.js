#!/bin/env node

require('coffee-script/register');
var BitInk = require('./bitink');

(function () {
  var bitInk = new BitInk;
  bitInk.start()
})()
