gulp = require 'gulp'
path = require 'path'

# Gulp Plugins
rimraf         = require 'gulp-rimraf'
mainBowerFiles = require 'main-bower-files'
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
gutil         = require 'gulp-util'
jade          = require 'gulp-jade'
less          = require 'gulp-less'
templateCache = require 'gulp-angular-templatecache'
uglify        = require 'gulp-uglify'
filesize      = require 'gulp-filesize'
filter        = require 'gulp-filter'
plumber       = require 'gulp-plumber'
ngAnnotate    = require 'gulp-ng-annotate'
webserver     = require 'gulp-webserver'
coffeelint    = require 'gulp-coffeelint'

parameters    = require './parameters.coffee'

# Build tasks
gulp.task 'build', ['copy', 'compile']
gulp.task 'build-production', ['clean', 'build', 'minify']

# Utility tasks
gulp.task 'clean', ->
  rimraf parameters.web_path

gulp.task 'copy', ['assets', 'vendors']

gulp.task 'assets', [], ->
  gulp.src "#{parameters.assets_path}/**"
  .pipe gulp.dest parameters.web_path

# Compilation tasks
gulp.task 'compile', ['coffee', 'templates', 'jade', 'less']

gulp.task 'less', ->
  gulp.src parameters.less_main_file
  .pipe plumber()
  .pipe less paths: [ path.join(__dirname) ]
  .pipe gulp.dest "#{parameters.web_path}/css"
  .on 'error', gutil.log

gulp.task 'templates', ->
  gulp.src "#{parameters.app_path}/*/**/*.jade"
  .pipe plumber()
  .pipe jade doctype: 'html'
  .pipe templateCache
      filename: parameters.templates_file
      module: parameters.templates_module
      standalone: true
  .pipe gulp.dest "#{parameters.web_path}/js"
  .on 'error', gutil.log

gulp.task 'jade', ->
  gulp.src "#{parameters.app_path}/**/*.jade"
  .pipe plumber()
  .pipe jade pretty: true
  .pipe gulp.dest parameters.web_path
  .on 'error', gutil.log

# JS vendors will be read from bower.json order and concatenate into [web_path]/js/[vendor_main_file]
gulp.task 'vendors', ->
  gulp.src mainBowerFiles()
  .pipe filter '**/*.js'
  .pipe concat parameters.vendor_main_file
  .pipe gulp.dest "#{parameters.web_path}/js"
  .on 'error', gutil.log

coffeeFiles = [
  "#{parameters.app_path}/**/module.coffee"
  "#{parameters.app_path}/**/*.coffee"
]

gulp.task 'coffee', ->
  gulp.src coffeeFiles
  .pipe plumber()
  .pipe coffee bare: true
  .pipe concat parameters.app_main_file
  .pipe gulp.dest "#{parameters.web_path}/js"
  .on 'error', gutil.log

gulp.task 'lint', ->
  gulp.src coffeeFiles
  .pipe coffeelint 'coffeelint.json'
  .pipe coffeelint.reporter()
  .pipe coffeelint.reporter 'fail'

gulp.task 'minify', ['coffee', 'templates'], ->
  gulp.src "#{parameters.web_path}/**/*.js"
  .pipe ngAnnotate()
  .pipe uglify()
  .pipe gulp.dest parameters.web_path
  .on 'error', gutil.log

gulp.task 'watch', ['build'], ->
  gulp.watch "#{parameters.app_path}/**/*", ['compile']
  gulp.watch "#{parameters.app_path}/**/*.coffee", ['lint']
  gulp.watch 'bower_components', ['compile']

  gulp.src parameters.web_path
  .pipe webserver
    host: 'localhost'
    port: 8000
    livereload: true
    fallback: 'index.html'
    open: true
