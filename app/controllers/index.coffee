express = require 'express'
router = express.Router()

# map routes to controllers
router.use '/cv', require './cv'
router.use '/', (req, res, next) -> res.render 'index'

module.exports = router
