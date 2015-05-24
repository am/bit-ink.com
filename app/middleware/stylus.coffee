stylus = require 'stylus'
rupture = require 'rupture'
nib = require 'nib'

module.exports = ->
  @compileStylus = (str, path) ->
    stylus(str)
      .set('filename', path)
      .set('compress', true)
      .set('include css', true)
      .use(rupture())
      .use(nib())
      .import('nib')

  stylus.middleware(
    src: "#{__dirname}/../stylus"
    dest: "#{__dirname}/../public/css"
    compile: @compileStylus
  )
