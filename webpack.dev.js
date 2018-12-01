const path = require('path')
const merge = require('webpack-merge')
const common = require('./webpack.common')

module.exports = merge(common, {
  mode: 'development',
  devtool: 'source-map',
  optimization: {
    nodeEnv: 'development'
  },
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    historyApiFallback: true,
    noInfo: false,
    compress: true,
    overlay: true,
  }
})