express = require 'express'
router = express.Router()

router.get '/', (req, res, next) ->
  res.send 'view source'

module.exports = router
