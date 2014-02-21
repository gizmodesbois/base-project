// require('coffee-script/register');
// require('./gulpfile.coffee');
var gulp = require('gulp'),
    gutil = require('gulp-util'),
    imagemin = require('gulp-imagemin'),
    notify = require('gulp-notify'),
    livereload = require('gulp-livereload'),
    clean = require('gulp-clean'),
    lr = require('tiny-lr'),
    autoprefixer = require('gulp-autoprefixer'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat'),
    server = lr();


gulp.task('images', function() {
    return gulp.src('assets/img/**/*')
        .pipe(imagemin({
            optimizationLevel: 1,
            progressive: true,
            interlaced: true
        }))
        .pipe(gulp.dest('dist/assets/img'))
        .pipe(livereload(server))
        .pipe(notify({
            message: '<%= file.relative %> complete',
            title: 'Images compression'
        }));
});

gulp.task('styles', function() {
    return gulp.src('assets/css/scss/screen.scss')
        .pipe(sass({
            config_file: 'assets/config.rb'
        }))
        .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(minifycss())
        .pipe(gulp.dest('dist/assets/css'))
        .pipe(livereload(server))
        .pipe(notify({
            message: '<%= file.relative %> generated',
            title: 'Styles compression'
        }))
})

gulp.task('scripts', function() {
    return gulp.src('assets/js/**/*')
    //.pipe(jshint('.jshintrc'))
    //.pipe(jshint.reporter('default'))
    .pipe(concat('main.js'))
        .pipe(rename({
            suffix: '.min'
        }))
        .pipe(uglify())
        .pipe(gulp.dest('dist/assets/js'))
        .pipe(livereload(server))
        .pipe(notify({
            message: '<%= file.relative %> generated',
            title: 'Javascript task'
        }))
})

gulp.task('clean', function() {
    return gulp.src(['dist/assets/css', 'dist/assets/js', 'dist/assets/img'], {
        read: false
    })
        .pipe(clean())
        .pipe(notify({
            message: 'Directories cleaned',
            title: 'Cleaner notifications'
        }));
});

gulp.task('watch', function() {

    // Listen on port 35729
    server.listen(35729, function(err) {
        if (err) {
            return console.log(err)
        };

        // Watch tasks go inside inside server.listen()

    });

    // Watch .scss files
    gulp.watch('assets/src/css/scss/**/*.scss', ['styles']);

    // Watch .js files
    gulp.watch('assets/src/js/scripts/**/*.js', ['scripts']);

    // Watch image files
    gulp.watch('assets/src/img/**/*', ['images']);

});

// Default tasks that can be run
gulp.task('default', ['clean'], function() {
    gulp.start('images', 'scripts');
    gutil.log('This is your first task with', gutil.colors.cyan('colors'));
});