# express = require 'express'
# router = express.Router()
{Router} = require 'express'
viewsourceRouter = Router()

Github = require 'github'
NodeCache =  require 'node-cache'
path = require 'path'
jade = require 'jade'

###
configuration
###

GH_VERSION = "3.0.0"
GH_DEBUG = on
GH_TIMEOUT = 5000
GH_USER = 'am'
GH_REPO = 'www.bit-ink.com'

FILE_TYPES =
  js: 'javascript'
  coffee: 'coffeescript'
  html: 'html'
  jade: 'jade'


cache = new NodeCache stdTTl: 100, checkperiod: 120
github = new Github(
  version: GH_VERSION
  debug: GH_DEBUG
  timeout: GH_TIMEOUT
)

###
helper methods
###

githubResolve = (resolve, reject, href) ->
  (err, res, next) ->
    if err? then reject err
    else
      setCache href, res
      resolve res

cacheKey = (href) ->
  "viewsource_#{ href }"

getCache = (href) ->
  cache.get cacheKey href

setCache = (href, content) ->
  cache.set cacheKey(href), content

githubSettings = (href) ->
  user: GH_USER
  repo: GH_REPO
  path: href

getModelPromise = (href = '') ->
  href = href.replace /\/$/, ''

  new Promise (resolve, reject) ->
    cached = getCache href

    if cached then resolve cached
    else
      github.repos.getContent(
        githubSettings href
        githubResolve resolve, reject, href
      )

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
