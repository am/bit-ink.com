express = require 'express'
router = express.Router()
Github = require 'github'
NodeCache =  require 'node-cache'
path = require 'path'
jade = require 'jade'

cache = new NodeCache stdTTl: 100, checkperiod: 120
github = new Github(
  version: "3.0.0"
  debug: on
  timeout: 5000
)

getModelPromise = (href = '') ->
  href = href.replace /\/$/, ''

  new Promise (resolve, reject) ->
    cachekey = "cache#{ href }"
    cached = cache.get  cachekey

    if cached then resolve cached
    else
      github.repos.getContent(
        user: 'am'
        repo: 'www.bit-ink.com'
        path: href
        , (err, res, next) ->
          content = JSON.stringify res
          cache.set cachekey, res
          resolve res
      )

addSlash = (path) ->
  endSlash = /\/$/
  hasSlash = endSlash.test path
  if hasSlash then path else "#{ path }/"

router.get '/:href(*)', (req, res, next) ->
  modelPromise = getModelPromise req.params.href
  modelPromise.then (model) ->
    if model.length then collection = model
    else file = new Buffer model.content, 'base64'

    res.render 'viewsource',
      collection: collection,
      file: file
      root: "/viewsource#{ addSlash req.path }"

module.exports = router
