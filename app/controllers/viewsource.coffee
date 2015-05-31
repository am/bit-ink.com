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

modelPromise = (href = '') ->
  new Promise (resolve, reject) ->
    cached = cache.get  "cache#{ href }"

    if cached then resolve cached
    else
      github.repos.getContent(
        user: 'am'
        repo: 'www.bit-ink.com'
        path: href
        , (err, gh_res, next) ->
          content = JSON.stringify(gh_res)
          cache.set 'source', content
          resolve content
      )

router.get '/:href(*)', (req, res, next) ->
  modelPromise = modelPromise req.params.href
  modelPromise.then (model) ->
    res.render 'viewsource', github: JSON.parse model

module.exports = router
