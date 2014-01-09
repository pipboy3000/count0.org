LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT})
mountFolder = (connect, dir) ->
  return connect.static(require('path').resolve(dir))

module.exports =  ->
  @initConfig
    pkg: @file.readJSON 'package.json'
    concat:
      dist:
        src: ['src/_assets/js/vendor/*.js', 'src/_assets/js/*.js']
        dest: 'src/js/script.js'
    compass:
      dist:
        options:
          config: 'compass.rb'
          environment: 'production'
          bundleExec: true
    coffee:
      dist:
        expand: true
        flatten: true
        src: ['src/_assets/coffee/*.coffee']
        dest: ['src/_assets/js/']
        ext: '.js'
    watch:
      options:
        livereload: LIVERELOAD_PORT
      js:
        files: ['src/_assets/js/**/*.js']
        tasks: ['concat']
      compass:
        files: ['src/_assets/scss/**/*.scss']
        tasks: ['compass']
      coffee:
        files: ['src/_assets/coffee/**/*.coffee']
        tasks: ['coffee']
      html:
        files: ['_site/*.html']
        tasks: []
    connect:
      options:
        port: 9000
      livereload:
        options:
          middleware: (connect) ->
            return [mountFolder(connect, './_site/'), lrSnippet]

  @loadNpmTasks 'grunt-contrib-coffee'
  @loadNpmTasks 'grunt-contrib-compass'
  # @loadNpmTasks 'grunt-contrib-jshint'
  @loadNpmTasks 'grunt-contrib-watch'
  # @loadNpmTasks 'grunt-contrib-uglify'
  @loadNpmTasks 'grunt-contrib-connect'
  @loadNpmTasks 'grunt-contrib-concat'
  @loadNpmTasks 'grunt-notify'

  @registerTask 'default', ['connect', 'watch']
