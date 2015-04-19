var gulp = require('gulp');
var jade = require('gulp-jade');
var browserSync = require('browser-sync');
var sass = require('gulp-sass');

var paths = {
    dist: './dist/',
    app: './app/'
};
gulp.task('jade', function() {
    gulp.src(paths.app + 'index.jade')
        .pipe(jade({
            pretty: true
        }))
        .pipe(gulp.dest(paths.dist));
});

gulp.task('copy', function() {
  gulp.src([
    paths.app + 'img/**/*'
    ]).pipe(gulp.dest(paths.dist + 'img'));
});

gulp.task('sass', function () {
    gulp.src(paths.app + 'sass/styles.sass')
        .pipe(sass({
            indentedSyntax: true
        }))
        .pipe(gulp.dest(paths.dist + 'css'));
});

gulp.task('browser-sync', function() {
    browserSync({
        server: {
            baseDir: "./dist/"
        }
    });
});

gulp.task('default', ['copy', 'sass', 'jade', 'browser-sync']);
