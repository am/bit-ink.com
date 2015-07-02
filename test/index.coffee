should = require 'should'
sinon = require 'sinon'
App = require('../app/')
express = require 'express'

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

  it 'should call setup', ->
    @setupSpy = sinon.spy App::, 'setup'
    new App
    @setupSpy.calledOnce.should.be.true()

  it 'should call server', ->
    @serverSpy = sinon.spy App::, 'server'
    new App
    @serverSpy.calledOnce.should.be.true()
