const path = require('path')
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
const isProductionMode = process.env.NODE_ENV === 'production'

module.exports = {
  entry: [ './src/js/main.js' ],
  output: {
    path: path.resolve(__dirname, 'dist', 'assets'),
    filename: 'bundle.js',
    publicPath: '/assets/'
  },
  module: {
    rules: [
      { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader' },
      {
        test: /\.(png|jpg|gif)$/i,
        use: [{
          loader: 'url-loader',
          options: { limit: 8192 }
        }]
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        use: [{
          loader: 'file-loader',
          options: {
            name: '[name].[ext]'
          }
        }]
      },
      {
        test: /\.s[ac]ss$/i,
        use: [
          isProductionMode ? MiniCssExtractPlugin.loader : 'style-loader',
          'css-loader',
          'postcss-loader',
          'sass-loader'
        ]
      }
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: "style.css" })
  ],
  resolve: {
    extensions: ['.js'],
  }
};
