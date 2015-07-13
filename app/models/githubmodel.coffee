Github = require 'github'

class GithubModel
  version = "3.0.0"
  debug = on
  timeout = 5000

  api: null
  user: 'am'
  repo: 'www.bit-ink.com'

  constructor: (@cache) ->
    @api = new Github(
      version: version
      debug: debug
      timeout: timeout
    )

  cacheKey: (href) ->
    "viewsource_#{ href }"

  getCache: (href) ->
    @cache.get @cacheKey href

  setCache: (href, content) ->
    @cache.set @cacheKey(href), content

module.exports = GithubModel
