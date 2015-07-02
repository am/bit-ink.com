should = require 'should'
sinon = require 'sinon'
express = require 'express'
path = require 'path'
fs = require 'fs'
StylusMiddleware = require '../app/middleware/stylus'

App = require '../app/'

describe 'application Class instance', ->
  app = new App

  it 'should be a class', ->
    App.should.be.Class

  it 'should return an Object', ->
    app.should.be.Object

  it 'should have an Express instance', ->
    should.exist(app.express)
    app.express.should.be.Function

describe 'application initialization', ->
  app = new App

  it 'should call setup', ->
    spy = sinon.spy app, 'setup'
    app.setup()
    spy.calledOnce.should.be.true()

  it 'should call server', ->
    spy = sinon.spy app, 'server'
    app.server()
    spy.calledOnce.should.be.true()

describe 'setup', ->
  app = new App
  spy = sinon.spy app.express, 'set'
  app.setup()

  it 'should configure views', ->
    # Code smell here, now the test file can't be moved since this path is relative
    viewsPath = path.join __dirname, '../app/views'
    spy.calledWith('views', viewsPath).should.be.true()

  it 'should configure jade as view engine', ->
    spy.calledWith('view engine', 'jade').should.be.true()

  it 'should setup stylus middleware', ->
    spy.calledWith(new StylusMiddleware)
