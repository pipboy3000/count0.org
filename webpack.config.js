const webpack = require('webpack')
const path = require('path')
const autoprefixer = require('autoprefixer')
const moduleImporter = require('sass-module-importer')
const ExtractTextPlugin = require("extract-text-webpack-plugin")
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')

module.exports = {
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      },
      {
        test: /\.gif/,
        loader: "url-loader?limit=10000&mimetype=image/gif"
      },
      {
        test: /\.jpg/,
        loader: "url-loader?limit=10000&mimetype=image/jpg"
      },
      {
        test: /\.png/,
        loader: "url-loader?limit=10000&mimetype=image/png"
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "url-loader?limit=10000&mimetype=application/font-woff"
      },
      {
        test: /\.(ttf|eot|svg|ttf)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "file-loader"
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {loader: 'css-loader'},
            {
              loader: 'postcss-loader',
              options: { plugins: [autoprefixer] } 
            },
            {
              loader: 'sass-loader',
              options: {
                includePaths: [ path.resolve(__dirname, 'src', 'scss') ],
                importer: moduleImporter()
              }
            }
          ]
        })
      }
    ]
  },
  entry: [ './src/js/main.js' ],
  output: {
    path: path.resolve(__dirname, 'dist', 'assets'),
    filename: 'bundle.js',
    publicPath: '/assets/'
  },
  plugins: [
    new ExtractTextPlugin({
      filename: 'style.css',
      allChunks: true,
      disable: false
    })
  ],
  resolve: {
    extensions: ['.js',],
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  },
  devtool: 'source-map'
};

if (process.env.NODE_ENV === 'production') {
  module.exports.plugins = (module.exports.plugins || []).concat([
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    }),
    new UglifyJsPlugin(),
    new webpack.LoaderOptionsPlugin({ minimize: true })
  ])
}
