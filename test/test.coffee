should = require 'should'
App = require('../app/')
express = require 'express'

describe 'application', ->
  app = new App

  it 'should be a class', ->
    App.should.be.Class

  it 'should return an Object', ->
    app.should.be.Object

  it 'should have an Express instance', ->
    should.exist(app.express)
    app.express.should.be.Function
