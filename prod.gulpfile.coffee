gulp = require("gulp")
gutil = require("gulp-util")

gulp.task "default", ->
  gutil.log "This is the",gutil.colors.green("PRODUCTION"),"environnement for gulp"
  return