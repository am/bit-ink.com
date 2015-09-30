should = require 'should'
sinon = require 'sinon'
express = require 'express'
path = require 'path'
fs = require 'fs'
logger = require 'morgan'
controllers = require '../app/controllers'
config = require '../app/config'

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
  setSpy = sinon.spy app.express, 'set'
  useSpy = sinon.spy app.express, 'use'
  app.setup()

  it 'should set views', ->
    # Code smell, now the test file can't be moved since this path is relative
    viewsPath = path.join __dirname, '../app/views'
    setSpy.calledWith('views', viewsPath).should.be.true()

  it 'should set jade as view engine', ->
    setSpy.calledWith('view engine', 'jade').should.be.true()

  it 'should use components mount for static bower components assets', ->
    bowerComponentsPath = path.join __dirname, '../bower_components'
    useSpy.calledWith '/components', express.static bowerComponentsPath

  it 'should use public for static assets', ->
    publicPath = path.join __dirname, '../public'
    useSpy.calledWith express.static publicPath

  it 'should use logger with development configuration', ->
    useSpy.calledWith logger 'development'

  it 'should use controllers', ->
    useSpy.calledWith controllers

describe 'server', ->
  app = new App
  spy = sinon.spy app.express, 'listen'
  app.server()

  it 'should listen to port and address', ->
    spy.calledWith config.port, config.ipaddress, app.serverLog
