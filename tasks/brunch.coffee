{ spawn } = require 'child_process'

BASE = "#{__dirname}/../"

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
    brunchPath = "#{BASE}node_modules/.bin/brunch"
    command = switch action
      when 'serve'
        "#{brunchPath} watch --server --port #{port}"
      when 'watch'
        "#{brunchPath} watch --port #{port}"
      when 'compile'
        "#{brunchPath} build"
      when 'build'
        "#{brunchPath} build -P"

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
