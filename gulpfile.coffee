gulp = require 'gulp'
stylus = require 'gulp-stylus'
nib = require 'nib'
concat = require 'gulp-concat'
connect = require 'gulp-connect'
uglify = require 'gulp-uglify'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'

gulp.task 'default', ['stylus', 'jade', 'coffee', 'connect', 'watch']

gulp.task 'connect', ->
	connect.server
		port: 2000
		livereload: on
		root: 'dist'

gulp.task 'stylus', ->
	gulp.src 'stylus/*.styl'
	.pipe stylus
		compress: on
		use: nib()
	.pipe gulp.dest 'dist/css'
	.pipe do connect.reload


gulp.task 'jade', ->
	gulp.src 'jade/*.jade'
		.pipe do jade
		.pipe gulp.dest 'dist'
		.pipe do connect.reload

gulp.task 'coffee', ->
	gulp.src 'coffee/*.coffee'
	.pipe do coffee
	.pipe concat 'all.js'
	.pipe do uglify
	.pipe gulp.dest 'dist/js'
	.pipe do connect.reload

gulp.task 'watch', ->
	gulp.watch 'stylus/*.styl', ['stylus']
	gulp.watch 'jade/*.jade', ['jade']
	gulp.watch 'coffee/*.coffee', ['coffee']