const webpack = require('webpack')

module.exports = {
  build: {
    postcss: [
      require('postcss-normalize')(),
      require('autoprefixer')(),
    ],
  },
  modules: [
    // Simple usage
    ['@nuxtjs/google-analytics', {
      id: 'UA-5544272-7'
    }]
 ]
}
