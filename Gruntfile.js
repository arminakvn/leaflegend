module.exports = function(grunt) {

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),
  	coffee: {
  	    compile: {
  	      expand: true,
  	      flatten: true,
  	      cwd: __dirname + "/demo/assets/",
  	      src: ['demo.coffee'],
  	      dest: 'demo/assets/',
  	      ext: '.js'
  	    },
        compileDemo: {
          expand: true,
          flatten: true,
          cwd: __dirname + "/src/",
          src: ['main.coffee'],
          dest: 'src/',
          ext: '.js'
        }
  	},
    concat: {
      options: {
        separator: "\n\n"
      },
      dist: {
        src: [
          'src/_intro.js',
          'src/main.js',
          'src/_outro.js'
        ],
        dest: 'dist/<%= pkg.name.replace(".js", "") %>.js'
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name.replace(".js", "") %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
      },
      dist: {
        files: {
          'dist/<%= pkg.name.replace(".js", "") %>.min.js': ['<%= concat.dist.dest %>']
        }
      }
    },
    qunit: {
      files: ['test/*.html']
    },

    jshint: {
      files: ['dist/leaflegend.js'],
      options: {
        globals: {
          console: true,
          module: true,
          document: true
        },
        jshintrc: '.jshintrc'
      }
    },

    watch: {
  	  coffee: {
  	      files: ['demo/assets/*.coffee','src/*.coffee'],
  	      tasks: ['coffee:compile', 'coffee:compileDemo']
  	  },
        files: ['<%= jshint.files %>'],
        tasks: ['coffee', 'concat', 'jshint', 'qunit']
      }

  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-concat');

  grunt.registerTask('test', ['jshint', 'qunit']);
  grunt.registerTask('default', ['coffee', 'concat', 'jshint', 'qunit', 'uglify']);

};
