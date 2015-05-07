var gulp = require('gulp'),
    jade = require('gulp-jade'),
    browserSync = require('browser-sync'),
    sass = require('gulp-sass'),
    coffee = require('gulp-coffee'),
    concat = require('gulp-concat'),
    util = require('gulp-util');

var paths = {
  dist: './dist/',
  app: './app/'
};

gulp.task( 'jade', function() {
  gulp.src( paths.app + 'index.jade' )
    .pipe( jade({
      pretty: true
    }))
    .pipe( gulp.dest( paths.dist ));
});

gulp.task( 'copy_assets', function() {
  gulp.src( paths.app + 'assets/**/*' )
    .pipe( gulp.dest( paths.dist ));
});

gulp.task( 'sass', function () {
  gulp.src( paths.app + 'sass/styles.sass' )
    .pipe( sass({
      indentedSyntax: true
    }))
    .pipe( gulp.dest( paths.dist + 'css' ));
});

gulp.task( 'coffee', function () {
  gulp.src( paths.app + 'scripts/about.coffee' )
    .pipe( coffee({ bare: true }))
    .pipe( gulp.dest( paths.dist + 'scripts' ))
    .on( 'error', util.log );
});

gulp.task( 'browser-sync', function() {
  browserSync({
    server: {
      baseDir: "./dist/"
    }
  });
});

gulp.task( 'default', [ 'copy_assets', 'sass', 'jade', 'coffee', 'browser-sync' ]);
