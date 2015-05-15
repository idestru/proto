gulp    = require 'gulp'
stylus  = require 'gulp-stylus'
nib     = require 'nib'
concat  = require 'gulp-concat'
connect = require 'gulp-connect'
uglify  = require 'gulp-uglify'
jade    = require 'gulp-jade'
coffee  = require 'gulp-coffee'
wiredep = require('wiredep').stream
plumber = require 'gulp-plumber'
notify  = require 'gulp-notify'
# useref = require 'gulp-useref'

gulp.task 'default', ['stylus', 'bower', 'jade', 'coffee', 'connect', 'watch']

gulp.task 'connect', ->
	connect.server
		port: 2000
		livereload: on
		root: 'dist'

gulp.task 'stylus', ->
	gulp.src 'src/stylus/*.styl'
	.pipe plumber
		errorHandler: notify.onError '<%= error.message %>'
	.pipe stylus
		# compress: on
		use: nib()
	.pipe gulp.dest 'dist/css'
	.pipe notify "Stylus compiled <%= file.relative %> successfully! "
	.pipe do connect.reload


gulp.task 'jade', ->
	gulp.src 'src/jade/*.jade'
	.pipe plumber
		errorHandler: notify.onError '<%= error.message %>'
	.pipe jade
		pretty: yes
	.pipe gulp.dest 'dist'
	.pipe notify "Jade compiled <%= file.relative %> successfully! "
	.pipe do connect.reload

gulp.task 'coffee', ->
	gulp.src 'src/coffee/*.coffee'
	.pipe plumber
		errorHandler: notify.onError '<%= error.message %>'
	.pipe do coffee
	.pipe concat 'all.js'
	.pipe do uglify
	.pipe gulp.dest 'dist/js'
	.pipe notify "Coffee compiled <%= file.relative %> successfully! "
	.pipe do connect.reload

gulp.task 'bower', ->
	gulp.src 'src/jade/*.jade'
	.pipe plumber
		errorHandler: notify.onError '<%= error.message %>'
	.pipe wiredep
		exclude: [ /html5shiv/, '/respond/' ],
		ignorePath: '../../dist/'
		# set in .bowwerrc
		# directory: 'dist/libs'
	.pipe gulp.dest 'src/jade'
	.pipe notify "Wiredep injected bower components to <%= file.relative %> successfully! "

# gulp.task 'build', ->
# 	assets = useref.assets()
# 	gulp.src 'src/jade/*.jade'
# 		.pipe(assets)
# 		.pipe(assets.restore())
# 		.pipe(useref())
# 		.pipe(gulp.dest('dist'))

gulp.task 'watch', ->
	gulp.watch 'src/stylus/*.styl', ['stylus']
	gulp.watch 'src/jade/*.jade', ['jade']
	gulp.watch 'src/coffee/*.coffee', ['coffee']
	gulp.watch 'bower.json', ['bower', 'jade']