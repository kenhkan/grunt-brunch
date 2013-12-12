{ spawn } = require 'child_process'

module.exports = (grunt) ->
  grunt.registerMultiTask "brunch", "Brunch asset pipeline", ->
    # Get the options
    options = grunt.config('brunch')[@target]
    grunt.verbose.writeflags options, "Options"
    { action, port, async } = options
    action ?= 'serve'
    port ?= 8888
    async ?= false

    # Always run asynchronously unless otherwise specified
    done = @async() unless async

    # Available command list
    command = switch action
      when 'serve'
        "node_modules/.bin/brunch watch --server --port #{port}"
      when 'watch'
        "node_modules/.bin/brunch watch --port #{port}"
      when 'compile'
        "node_modules/.bin/brunch build"
      when 'build'
        "node_modules/.bin/brunch build -P"

    # Run it
    [ cmd, args... ] = command.split ' '
    brunch = spawn cmd, args

    # Capture all output
    brunch.stdout.pipe process.stdout
    brunch.stderr.pipe process.stdout

    # Finish on close
    brunch.on 'close', done unless async

    # Quit child process on exit
    process.on 'exit', ->
      brunch.kill 'SIGHUP'
