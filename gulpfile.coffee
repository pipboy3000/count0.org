gulp = require 'gulp'
gulpLoadPlugins = require 'gulp-load-plugins'
$ = gulpLoadPlugins
  rename:
    'gulp-ruby-sass': 'sass'
cp = require 'child_process'
browserSync = require 'browser-sync'
reload = browserSync.reload
del = require 'del'

gulp.task 'sass', ->
    $.sass('src/_assets/scss/style.scss', sourcemap: false)
    .pipe $.plumber(errorHandler: $.notify.onError("Error: <%= error.message %>"))
    .pipe $.autoprefixer(browsers: '> 1%', 'last 2 versions')
    .pipe $.cssmin()
    .pipe gulp.dest 'src/css/'
    .pipe $.filter '**/*.css'
    .pipe reload(stream: true)

gulp.task 'js', ->
  gulp.src ['src/_assets/js/vendor/**/*.js', 'src/_assets/js/*.js']
    .pipe $.concat 'script.js'
    .pipe gulp.dest 'src/js'

gulp.task 'browser-sync', ->
  browserSync { server: { baseDir: '_site/' } }

gulp.task 'jekyll-build', (done)->
  cp.spawn('bundle', ['exec', 'jekyll', 'build', '--drafts'], {stdio: 'inherit'})
    .on('close', done)

gulp.task 'jekyll-rebuild', ['jekyll-build'], ->
  reload()

gulp.task 'watch', ->
  gulp.watch ['./_config.yml', 'src/**/*.html', 'src/_plugins/**/*.rb', 'src/**/*.md', 'src/css/*.css', 'src/js/*.js'], ['jekyll-rebuild']
  gulp.watch 'src/_assets/js/**/*.js', ['js']
  gulp.watch 'src/_assets/scss/**/*.scss', ['sass']

gulp.task 'default', ['watch', 'sass', 'js', 'jekyll-build', 'browser-sync']
