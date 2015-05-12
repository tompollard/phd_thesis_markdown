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
                title: "Thesis compilation", // defaults to the name in package.json, or will use project directory's name
                success: true, // whether successful grunt executions should be notified automatically
                duration: 2 // the duration of notification in seconds, for `notify-send only
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-make');
    grunt.loadNpmTasks('grunt-notify');

    grunt.registerTask('default', ['make:' + type]);
};
