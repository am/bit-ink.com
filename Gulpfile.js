var gulp = require('gulp');
var jade = require('gulp-jade');
var browserSync = require('browser-sync');

gulp.task('jade', function() {
    gulp.src('./app/index.jade')
        .pipe(jade({
            pretty: true
        }))
        .pipe(gulp.dest('./dist/'));
});

gulp.task('browser-sync', function() {
    browserSync({
        server: {
            baseDir: "./dist/"
        }
    });
});

gulp.task('default', ['jade', 'browser-sync']);
