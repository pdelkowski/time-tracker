module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        uglify: {
          options: {
            mangle: false,
            compress: {
              drop_console: true
            }
          },
          my_target: {
            files: {
              'app/app.min.js': ['app/app.js','app/main.js','app/config.constant.js','app/config.custom.js','app/config.router.js'],
              'app/components.min.js': ['app/controllers/*.js','app/services/*.js','app/directives/*.js'],
              // 'app/vendors.min.js': ['vendor/*/*.js'],
            }
          }
        }
    });
    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.registerTask('default', ["uglify"]);
};
