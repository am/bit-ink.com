should = require 'should'
BitInkApp = require '../app.coffee'

describe 'BitInkApp class', ->
    it 'should be a instance of the class', ->
      app = new BitInkApp
      app.should.be.an.instanceOf BitInkApp
