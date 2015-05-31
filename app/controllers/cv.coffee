express = require 'express'
router = express.Router()
marked = require 'marked'
jade = require 'jade'
path = require 'path'
fs = require 'fs'
Promise = require 'bluebird'

Promise.promisifyAll fs

router.get '/:page?', (req, res, next) ->
  page = req.params.page or 'index'
  md = path.join __dirname, "../../markdown/#{ page }.md"
  fs.readFileAsync(md).then (val) ->
    content = markdown: marked val.toString()
    html = jade.renderFile path.join(__dirname, '../views/markdown.jade'), content
    res.send html

module.exports = router
