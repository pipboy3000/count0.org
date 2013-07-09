LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT})
mountFolder = (connect, dir) ->
  return connect.static(require('path').resolve(dir))

module.exports =  ->
  @initConfig
    pkg: @file.readJSON 'package.json'
    compass:
      dist:
        options:
          config: 'compass.rb'
          bundleExec: true
    coffee:
      assets:
        expand: true
        flatten: true
        src: ['source/_assets/*.coffee']
        dest: ['js/']
        ext: '.js'
    watch:
      options:
        livereload: LIVERELOAD_PORT
      compass:
        files: ['source/_scss/**/*.scss']
        tasks: ['compass']
      coffee:
        files: ['source/_assets/**/*.coffee']
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
  @loadNpmTasks 'grunt-notify'

  @registerTask 'default', ['connect', 'watch']
