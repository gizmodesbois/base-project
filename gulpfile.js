var gulp = require('gulp'),
    gutil = require('gulp-util');

gulp.task('default', function() {
    gutil.log('This is your first task with', gutil.colors.cyan('colors'));
});