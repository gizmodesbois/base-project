gulp = require('gulp')
gutil = require('gulp-util')

# Default tasks that can be run
gulp.task 'default', ->
	gutil.log 'This is your first task with', gutil.colors.cyan 'colors'