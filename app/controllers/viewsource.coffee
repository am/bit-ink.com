express = require 'express'
router = express.Router()
Github = require 'github'
NodeCache =  require 'node-cache'
path = require 'path'
jade = require 'jade'

GH_VERSION = "3.0.0"
GH_DEBUG = on
GH_TIMEOUT = 5000
GH_USER = 'am'
GH_REPO = 'www.bit-ink.com'

cache = new NodeCache stdTTl: 100, checkperiod: 120
github = new Github(
  version: GH_VERSION
  debug: GH_DEBUG
  timeout: GH_TIMEOUT
)

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

getModelPromise = (href = '') ->
  href = href.replace /\/$/, ''

  new Promise (resolve, reject) ->
    cached = getCache href

    if cached then resolve cached
    else
      github.repos.getContent(
        user: GH_USER
        repo: GH_REPO
        path: href
        , githubResolve resolve, reject, href
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

router.get '/:href(*)', (req, res, next) ->
  modelPromise = getModelPromise req.params.href
  modelPromise.then (data) ->
    model =
      collection: getDirContent data
      file: getFileContent data
      dir: "/viewsource#{ addSlash req.path }"

    res.render 'viewsource', model

  modelPromise.catch (error) ->
    console.log error.code
    res.status(error.code).render '404'

module.exports = router
