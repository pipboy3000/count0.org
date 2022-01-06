const path = require('path')
const { defineConfig } = require('vite')

module.exports = defineConfig({
  root: './dist',
  build: {
    lib: {
      entry: path.resolve(__dirname, 'dist/assets/main.js'),
      name: 'Main',
      fileName: (format) => `main.${format}.js`
    },
    outDir: './assets',
  }
});
