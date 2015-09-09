GithubModel = require './githubmodel'
Promise = require 'bluebird'

class RepoContent extends GithubModel

  getContent: (@path) ->
    new Promise (resolve, reject) =>
      cached = @getCache @path
      # try to get data from cache
      if cached then resolve cached
      else
        @fetch resolve, reject

  fetch: (resolve, reject) ->
    params =
      user: @user
      repo: @repo
      path: @path
    @api.repos.getContent params, @onReposGetContent resolve, reject

  onReposGetContent: (resolve, reject) ->
    (err, res, next) =>
      if err? then reject err
      else
        @setCache @path, res
        resolve res

module.exports = RepoContent
