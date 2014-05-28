module.exports =  ->
  require('load-grunt-tasks')(@, {pattern: ['grunt-*']})

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
        livereload: true
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
      server:
        options:
          port: 9000
          livereload: true
          base: '_site'

  @registerTask 'default', ['connect', 'watch']
