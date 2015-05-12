#!/bin/env node

require('coffee-script/register');
var BitInk = require('./bitink');

(function () {
  bitInk = new BitInk;
  bitInk.start()
})()
