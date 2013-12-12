{ spawn } = require 'child_process'

module.exports = (grunt) ->
  grunt.registerMultiTask "brunch", "Brunch asset pipeline", ->
    # Always run asynchronously
    done = @async()

    # Get the options
    options = grunt.config('brunch')[@target]
    grunt.verbose.writeflags options, "Options"
    { action, port } = options
    action ?= 'serve'
    port ?= 8888

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
    brunch.on 'close', done
