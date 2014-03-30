var gulp = require('gulp'),
    jade = require('gulp-jade'),
    browserify = require('gulp-browserify'),
    stylus = require('gulp-stylus'),
    lr = require('tiny-lr'),
    livereload = require('gulp-livereload'),
    color = require('cli-color'),
    express = require('express'),
    rename = require('gulp-rename'),
    gutil = require('gulp-util'),
    filter = require('gulp-filter'),
    manifest = require('gulp-manifest');

// Initialise Tiny LiveReload and environment variables

var server = lr(),
    env = process.env.NODE_ENV === 'production' ? 'production' : 'develpoment',
    production = env === 'production',
    SERVER_PORT = process.env.PORT || 5000;

// Paths configuration

var paths = {
    staticDir: 'www',
    views: { watch: [ 'views/**/*.jade', 'content/**/*' ], src: 'views/**/*.jade', out: 'www' },
    browserify: { watch: 'src/**/*.coffee' , src: 'src/index.coffee', out: 'www/js' },
    styles: { watch: 'styles/**/*.styl', src: 'styles/main.styl', out: 'www/css' }
};

// File filters used in build tasks

var filters = {
    isNotUnderscored: function (file) {
        var segments = file.path.split('/'),
            filename = segments[segments.length - 1];

        return filename.substr(0, 1) !== '_';
    }
};

// Beep function for error handling

function beep () {
    console.log('\007');
}

// Custom handler for compiling errors

function handleError (error) {
    beep(error);
    console.log(color.bold('[ error caught ]:\n') + color.red(error));
}

// Bundle JavaScript with Browserify

gulp.task('browserify', function () {
    gulp.src(paths.browserify.src,  { read: false })
    .pipe(browserify({
        transform: [ 'coffeeify' ],
        extensions: [ '.coffee' ]
    }))
    .on('error', handleError)
    .pipe(rename('index.js'))
    .pipe(gulp.dest(paths.browserify.out))
    .pipe(livereload(server));
});

// Compile Stylus into CSS

gulp.task('styles', function () {
    gulp.src(paths.styles.src)
    .pipe(stylus({
        pretty: !production,
        use: [ 'griddy', 'nib' ]
    }))
    .on('error', handleError)
    .pipe(gulp.dest(paths.styles.out))
    .pipe(livereload(server));
});

// Compile Jade views into HTML

gulp.task('views', function () {
    gulp.src(paths.views.src)
    .pipe(filter(filters.isNotUnderscored))
    .pipe(jade({
        pretty: !production,
        locals: {
            env: env,
            production: production
        }
    }))
    .on('error', handleError)
    .pipe(gulp.dest(paths.views.out))
    .pipe(livereload(server));
});

// LiveReload task used in every other build task

gulp.task('livereload', function (next) {
    livereload(server);
    next();
});

// LiveReload server task

gulp.task('listen', function (next) {
    server.listen(35729, next);
});

// Static server task

gulp.task('server', function (next) {
    var app = express();

    app.use(express.static(paths.staticDir))
    .listen(SERVER_PORT, function () {
        gutil.log(color.yellow('Listening on port ' + SERVER_PORT));
        next();
    });
});

gulp.task('manifest', function(){
    gulp.src([
        paths.staticDir + '***/**/*'
    ])
    .pipe(manifest({
        hash: true,
        preferOnline: true,
        network: ['http://*', '*'],
        filename: 'app.manifest',
        exclude: 'app.manifest'
     }))
    .pipe(gulp.dest(paths.staticDir));
});

// Build the codebase

gulp.task('build', [ 'browserify', 'styles', 'views', 'manifest' ]);

// Watch the codebase for changes

gulp.task('watch', [ 'build', 'server', 'manifest', 'listen' ], function () {
    gulp.watch(paths.browserify.watch, [ 'browserify' ]);
    gulp.watch(paths.styles.watch, [ 'styles' ]);
    gulp.watch(paths.views.watch, [ 'views' ]);
});

// Default task set to build

gulp.task('default', [ 'build' ]);