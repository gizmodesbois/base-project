gulp = require("gulp")
gutil = require("gulp-util")

gulp.task "default", ->
  gutil.log "This is the",gutil.colors.yellow("STAGING"),"environnement for gulp"
  return