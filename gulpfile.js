var gulp = require('gulp');
var stylus = require('gulp-stylus');

gulp.task('default', function() {
  gulp.src('stylesheets/*.styl')
      .pipe(stylus())
      .pipe(gulp.dest('./'));
  // place code for your default task here
});

gulp.task('watch', function() {
  gulp.watch('**/*.styl', ['default']);
});
