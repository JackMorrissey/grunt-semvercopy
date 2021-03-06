module.exports = (grunt) ->
	grunt.initConfig
		clean:
			test: ['tmp']
		semvercopy:
			inlineObject:
				resources:
					name: "inlineResource"
					range: "~1.1"
					parentDirectory: "./test/fixtures/MyResource"
					dest: 'tmp/inlineResource'
			inlineObjects: 
				resources: [
					{
						name: "inlineResourcesA"
						range: "1.0.0 - 1.1.1"
						parentDirectory: "./test/fixtures/MyResource"
						dest: 'tmp/inlineResources/'
					},{
						name: "inlineResourcesB"
						range: "~2"
						parentDirectory: "./test/fixtures/MyResource"
						dest: 'tmp/inlineResources/'
					}
				]
			jsonFile: 
				resourcesFiles: './test/JSON/one.json'
			jsonFiles:
				resourcesFiles: ['./test/JSON/one.json', './test/JSON/two.json']
		nodeunit:
			tests: ['./test/*_test.js']

	grunt.loadTasks 'tasks'

	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-nodeunit'


	grunt.registerTask 'test', ['clean', 'semvercopy', 'nodeunit']
	grunt.registerTask 'default', ['test']