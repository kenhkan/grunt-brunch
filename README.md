# Drive Brunch with Grunt <br/>[![Build Status](https://secure.travis-ci.org/kenhkan/grunt-brunch.png?branch=master)](http://travis-ci.org/kenhkan/grunt-brunch) [![Dependency Status](https://gemnasium.com/kenhkan/grunt-brunch.png)](https://gemnasium.com/kenhkan/grunt-brunch) [![NPM version](https://badge.fury.io/js/grunt-brunch.png)](http://badge.fury.io/js/grunt-brunch) [![Stories in Ready](https://badge.waffle.io/kenhkan/grunt-brunch.png)](http://waffle.io/kenhkan/grunt-brunch)

Run Brunch.IO as a Grunt task


## Getting Started

Install this grunt plugin next to your project's [grunt.js
gruntfile][getting_started] with: `npm install grunt-brunch`

Then add this line to your project's `grunt.js` gruntfile:

```javascript
grunt.loadNpmTasks('grunt-brunch');
```

[grunt]: https://github.com/cowboy/grunt
[getting_started]:
https://github.com/cowboy/grunt/blob/master/docs/getting_started.md


## Usage

Configuration:

    grunt.initConfig({
      ...
      brunch: {
        // Watch and run server at 8888
        serve: {
          action: 'serve',
          port: 8888
        },
        // Just like 'serve' but an asnchronous task
        serveAsync: {
          action: 'serve',
          port: 8888,
          async: true
        },
        // Watch for file changes only
        watch: {
          action: 'watch',
          port: 8888
        },
        // Compile
        compile: {
          action: 'compile'
        },
        // Build (compile + minify + uglify)
        build: {
          action: 'build'
        }
      },
      ...
    });
