stylus = require 'stylus'
rupture = require 'rupture'
nib = require 'nib'

module.exports =
  dateNow: ->
    Date Date.now()

  compileStylus: (str, path) ->
    stylus(str)
      .set('filename', path)
      .set('compress', true)
      .set('include css', true)
      .use(rupture())
      .use(nib())
      .import('nib')
