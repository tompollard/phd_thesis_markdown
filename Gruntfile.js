module.exports = function(grunt) {

    var type = grunt.option('type');
    if(!type) type = 'pdf:html';

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        notify: {
            make: {
                options: {
                    message: "Compilation done"
                }
            }
        },
        watch: {
            options: {
                interrupt: true
            },
            scripts: {
                files: ['source/*.md'],
                tasks: ['make:' + type, 'notify:make']
            }
        },
        notify_hooks: {
            options: {
                enabled: true,
                max_jshint_notifications: 5, // maximum number of notifications from jshint output
                success: true, // whether successful grunt executions should be notified automatically
                duration: 2 // the duration of notification in seconds, for `notify-send only
            }
        },
        express: {
            all: {
                options: {
                    port: 9000,
                    hostname: "0.0.0.0",
                    bases: ['output'], // the directory to serve
                    livereload: true
                }
            }
        },
        open: {
            all: {
                path: 'http://localhost:<%= express.all.options.port%>/thesis.html'
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-make');
    grunt.loadNpmTasks('grunt-notify');
    grunt.loadNpmTasks('grunt-open');
    grunt.loadNpmTasks('grunt-express');

    grunt.task.run('notify_hooks');

    grunt.registerTask('default', ['make:' + type]);

    grunt.registerTask('server', [
        'express',
        'open',
        'watch'
    ]);
};
