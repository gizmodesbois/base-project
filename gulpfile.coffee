# Assets Input
input = "src/"
# Assets Output
output = "app/"

gulp = require("gulp")
gutil = require("gulp-util")
imagemin = require("gulp-imagemin")
notify = require("gulp-notify")
livereload = require("gulp-livereload")
clean = require("gulp-clean")
lr = require("tiny-lr")
autoprefixer = require("gulp-autoprefixer")
jshint = require("gulp-jshint")
uglify = require("gulp-uglify")
rename = require("gulp-rename")
concat = require("gulp-concat")
compass = require("gulp-compass")
minifycss = require("gulp-minify-css")
plumber = require('gulp-plumber')
watch = require('gulp-watch')
changed = require('gulp-changed')
connect = require('gulp-connect')
server = lr()

gulp.task "images", ->
  gulp.src(input + "assets/img/**/*").pipe(imagemin(
    optimizationLevel: 1
    progressive: true
    interlaced: true
  )).pipe(gulp.dest(output + "assets/img")).pipe(livereload(server)).pipe notify(
    message: "<%= file.relative %> complete"
    title: "Images compression"
  )

gulp.task "connect", connect.server(
  root: ['app']
  port: 9000
  livereload: false
  open:
    browser: "Google Chrome" # if not working OS X browser: 'Google Chrome'
)


gulp.task "styles", ->
  gulp.src(input + "assets/css/scss/screen.scss").pipe(compass(css: input + 'assets/css',sass: input + 'assets/css/scss')).pipe(autoprefixer("last 2 version", "safari 5", "ie 8", "ie 9", "opera 12.1", "ios 6", "android 4")).pipe(rename(suffix: ".min")).pipe(minifycss()).pipe(gulp.dest(output + "/assets/css")).pipe(livereload(server)).pipe notify(
    message: "<%= file.relative %> generated"
    title: "Styles compression"
  )

gulp.task "scripts", ->
  gulp.src(input + "assets/js/scripts/*").pipe(jshint(".jshintrc")).pipe jshint.reporter("default")
  gulp.src(input + "assets/js/**/*").pipe(concat("main.js")).pipe(rename(suffix: ".min")).pipe(uglify()).pipe(gulp.dest(output + "assets/js")).pipe(livereload(server)).pipe notify(
    message: "<%= file.relative %> generated"
    title: "Javascript task"
  )

gulp.task "html", ->
  gulp.src("./src/*.html").pipe(changed("./app")).pipe(minifyHTML()).pipe gulp.dest("./app")

gulp.task "clean", ->
  gulp.src([
    output + "assets/css"
    output + "assets/js"
    output + "assets/img"
  ],
    read: false
  ).pipe(clean()).pipe notify(
    message: "Directories cleaned"
    title: "Cleaner notifications"
  )

gulp.task "watch", ->

  # Listen on port 35729
  server.listen 35729, (err) ->
    return console.log(err)  if err
    return


  # Watch tasks go inside inside server.listen()

  # Watch .scss files
  gulp.watch input + "assets/css/scss/**/*.scss", ["styles"]

  # Watch .js files
  gulp.watch input + "assets/js/scripts/**/*.js", ["scripts"]

  # Watch image files
  gulp.watch input + "assets/img/**/*", ["images"]
  return


# Default tasks that can be run
gulp.task "default", ["images", "scripts", "styles"], ->
  gulp.start "connect", "watch"
  gutil.log "This is your first task with", gutil.colors.cyan("colors")
  return