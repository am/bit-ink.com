express = require 'express'
router = express.Router()

# map routes to controllers
router.use '/cv', require './cv'
router.use '/viewsource', require './viewsource'
router.get '/', (req, res, next) -> res.render 'index'
router.use (req, res, next) -> res.render '404'

module.exports = router
