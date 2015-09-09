{Router} = require 'express'
viewsourceRouter = Router()

NodeCache =  require 'node-cache'
RepoContent = require '../models/repocontent'
Promise = require 'bluebird'
path = require 'path'
jade = require 'jade'

###
configuration
###

FILE_TYPES =
  js: 'javascript'
  json: 'javascript'
  coffee: 'coffeescript'
  html: 'markup'
  jade: 'jade'
  md: 'markdown'
  css: 'css'
  styl: 'stylus'

cache = new NodeCache stdTTl: 100, checkperiod: 120

###
helper methods
###

getModelPromise = (href = '') ->
  href = href.replace /\/$/, ''
  new Promise (resolve, reject) ->
    model = new RepoContent cache
    promise = model.getContent href
    promise.then (data) ->
      resolve data
    promise.catch (error) ->
      reject error

addSlash = (path) ->
  endSlash = /\/$/
  hasSlash = endSlash.test path
  if hasSlash then path else "#{ path }/"

getDirContent = (data) ->
  data if data.length

getFileContent = (data) ->
  return null if data.length
  new Buffer data.content, 'base64'

getFileType = (data) ->
  return null if data.length
  FILE_TYPES[data.name.split('.').pop()] || 'none'

getViewsourceModel = (data, req) ->
  collection: getDirContent data
  file: getFileContent data
  fileType: getFileType data
  dir: "/viewsource#{ addSlash req.path }"

###
router
###

viewsourceRouter.route '/:href(*)'
  .get (req, res, next) ->
    ghPromise = getModelPromise req.params.href
    ghPromise.then (data) ->
      model = getViewsourceModel data, req
      res.renderPjax 'index', model

    ghPromise.catch (error) ->
      console.log error.code
      res.status(error.code).render '404'

module.exports = viewsourceRouter
