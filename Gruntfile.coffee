require 'coffee-script'

module.exports = ->
  # Project configuration
  @initConfig
    pkg: @file.readJSON 'package.json'

    # CoffeeScript compilation
    coffee:
      spec:
        options:
          bare: true
        expand: true
        cwd: 'spec'
        src: ['**.coffee']
        dest: 'spec'
        ext: '.js'

    # Automated recompilation and testing when developing
    watch:
      files: ['spec/*.coffee', 'tasks/*.coffee']
      tasks: ['test']

    # BDD tests
    cafemocha:
      nodejs:
        src: ['spec/*.coffee']
        options:
          reporter: 'dot'

    # Coding standards
    coffeelint:
      components: ['tasks/*.coffee']

  # Grunt plugins used for building
  @loadNpmTasks 'grunt-contrib-coffee'

  # Grunt plugins used for testing
  @loadNpmTasks 'grunt-contrib-watch'
  @loadNpmTasks 'grunt-cafe-mocha'
  @loadNpmTasks 'grunt-coffeelint'
