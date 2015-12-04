autoprefixer = require 'gulp-autoprefixer'
browserify   = require 'browserify'
browserSync  = require 'browser-sync'
buffer       = require 'vinyl-buffer'
del          = require 'del'
gulp         = require 'gulp'
imagemin     = require 'gulp-imagemin'
notify       = require 'gulp-notify'
plumber      = require 'gulp-plumber'
runSequence  = require 'run-sequence'
sass         = require 'gulp-sass'
source       = require 'vinyl-source-stream'
sourcemaps   = require 'gulp-sourcemaps'
spawn        = require('child_process').spawn
watchify     = require 'watchify'

$ = {
  dist: "dist/"
  scss: 'src/scss/**/*.scss'
  includePaths:  ['node_modules/']
  js: 'src/js/main.js'
  images: 'src/images/*'
  jekyll: [
    '_config.yml'
    'src/html/**/*.html'
    'src/html/**/*.md'
    'src/html/**/*.rb'
    'src/html/**/*.xml'
  ]
  fonts: ['node_modules/font-awesome/fonts/**']
  env: process.env.NODE_ENV
}

compile = (watch) ->
  b = browserify($.js, debug: true).transform("babelify", {presets: ["es2015", "react"]})

  if watch
    bundler = watchify(b)
    bundler.on 'update', ->
      console.log '-> bundling...'
      bundle()
  else
    bundler = b

  bundle = () ->
    bundler.bundle().on('error', (err) ->
      notify().write(err)
      this.emit 'end'
    )
    .pipe(source('bundle.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('dist/js'))

  bundle()

gulp.task 'clean', (cb) -> del([$.dist], cb)

gulp.task 'jsBuild', -> compile()

gulp.task 'jsWatch', -> compile(true)

gulp.task 'fonts', -> gulp.src($.fonts).pipe gulp.dest($.dist + 'fonts/')

gulp.task 'image', ->
  gulp.src($.images)
      .pipe(imagemin(progressive: true))
      .pipe gulp.dest($.dist + 'images/')

gulp.task 'assets', ['fonts', 'image']

gulp.task 'sass', ->
  gulp.src($.scss)
    .pipe plumber errorHandler: notify.onError('<%= error.message %>')
    .pipe sass includePaths: $.includePaths
    .pipe autoprefixer(
      browsers: ['> 1%', 'last 2 versions', 'Android 4']
      cascade: false
    )
    .pipe gulp.dest($.dist + 'css/')
    .pipe browserSync.stream()

jekyllExec = (cmd, done)->
  spawn('bundle', cmd, stdio: 'inherit')
    .on('close', done)
    .on 'exit', ()->
      console.log '-- jekyll finished build --'

gulp.task 'jekyllBuild', (done)->
  jekyllExec(['exec', 'jekyll', 'build'], done)

gulp.task 'jekyllDraft', (done)->
  jekyllExec(['exec', 'jekyll', 'build', '--draft'], done)

gulp.task 'browser-sync', ->
  browserSync.init(
    server:
      baseDir: $.dist
    files: [$.dist]
  )
  
  gulp.watch $.scss, ['sass']
  gulp.watch $.images, ['image']
  gulp.watch $.jekyll, ['jekyllDraft']

gulp.task 'default', ['clean'], (cb) ->
  runSequence('assets', 'sass', 'jekyllDraft', 'jsWatch', 'browser-sync')

gulp.task 'build', ['clean'], (cb) ->
  runSequence('assets', 'sass', 'jsBuild', 'jekyllBuild')
