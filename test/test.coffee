should = require 'should'
App = require '../app/'

describe 'BitInkApp class', ->
    it 'should be a instance of the class', ->
      app = App()
      app.should.exist()
