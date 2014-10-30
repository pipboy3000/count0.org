gulp = require 'gulp'
sass = require 'gulp-ruby-sass'
autoprefixer = require 'gulp-autoprefixer'
cssmin = require 'gulp-cssmin'
concat = require 'gulp-concat'
filter = require 'gulp-filter'
cp = require 'child_process'
browserSync = require 'browser-sync'
reload = browserSync.reload

gulp.task 'sass', ->
  gulp.src 'src/_assets/scss/style.scss'
    .pipe sass()
    .on 'error', (err) -> console.log err.message
    .pipe autoprefixer "> 1%"
    .pipe cssmin()
    .pipe gulp.dest 'src/css/'
    .pipe filter '**/*.css'
    .pipe reload(stream: true)

gulp.task 'js', ->
  gulp.src ['src/_assets/js/vendor/**/*.js', 'src/_assets/js/*.js']
    .pipe concat 'script.js'
    .pipe gulp.dest 'src/js'

gulp.task 'browser-sync', ->
  browserSync {
    server: {
      baseDir: '_site/'
    }
  }

gulp.task 'jekyll-build', (done)->
  cp.spawn('bundle', ['exec', 'jekyll', 'build', '--drafts'], {stdio: 'inherit'})
    .on('close', done)

gulp.task 'jekyll-rebuild', ['jekyll-build'], ->
  reload()

gulp.task 'watch', ->
  gulp.watch ['./_config.yml', 'src/**/*.html', 'src/_plugins/**/*.rb', 'src/**/*.md'], ['jekyll-rebuild']
  gulp.watch 'src/_assets/js/**/*.js', ['js', reload]
  gulp.watch 'src/_assets/scss/**/*.scss', ['sass']
  gulp.watch '_site/js/**/*.js', [reload]

gulp.task 'default', ['watch', 'sass', 'js', 'jekyll-build', 'browser-sync']
