module.exports = (grunt) ->
	semver = require 'semver'
	path = require 'path'

	grunt.loadNpmTasks 'grunt-contrib-copy'
	
	readResourcesFromJSONFile = (src) ->
		normalizedSrc = path.normalize src
		content = grunt.file.readJSON normalizedSrc
		if !content
			grunt.log.errorlns "Unable to readJSON from " + normalizedSrc + "."
			return null
		resources = content.resources
		if !resources
			grunt.log.errorlns "No 'resources' object/array found in " + normalizedSrc + "."
			return null
		return resources

	resolveToArray = (inputObject) ->
		if inputObject
			kindOf = grunt.util.kindOf inputObject
			if kindOf == "array"
				return inputObject
			else if kindOf == "object" or kindOf == "string"
				return [inputObject]
		return []

	parseResources = (dataResources, resourcesFiles) ->
		resources = []
		if !dataResources and !resourcesFiles
			grunt.fail.warn "semverCopy config needs at least one of 'resources' or 'resourcesFiles' set."
		if dataResources
			resources = resources.concat resolveToArray dataResources
		if resourcesFiles
			files = resolveToArray resourcesFiles
			for resourceFile in files
				readResources = readResourcesFromJSONFile resourceFile
				(resources = resources.concat resolveToArray readResources) if readResources != null
		return resources

	isValidSemVerFolder = (src) ->
		return (grunt.file.isDir src) and (semver.valid path.basename src)
		
	determineMaxSatisfyingSemVerFolder = (semVerRange, parentDirectory) ->
		grunt.fail.warn "Invalid SemVer range \"" + semVerRange + "\"." if (semver.validRange semVerRange) == null
		expandOptions =
			cwd: parentDirectory
			filter: isValidSemVerFolder
		potentialMatchingFolders = grunt.file.expand(expandOptions, '*')
		if !potentialMatchingFolders or potentialMatchingFolders.length == 0
			grunt.fail.warn "No potential SemVer folders found."
		maxSatisfying = semver.maxSatisfying potentialMatchingFolders, semVerRange
		if !maxSatisfying
			grunt.fail.warn "No folders matched \"" + semVerRange + "\"."
		return maxSatisfying

	resolveMaxSemVerFolder = (resource) ->
		if !resource.name or !resource.range or !resource.parentDirectory
			grunt.fail.warn "Missing name, range, or parentDirectory in resource."
		maxSemVerFolder = determineMaxSatisfyingSemVerFolder resource.range, resource.parentDirectory
		fullPathToMaxSemVerFolder = path.join resource.parentDirectory, maxSemVerFolder
		return fullPathToMaxSemVerFolder

	queueSemVerFolderCopy = (srcFolder, resource, taskName, taskNumber) ->
		copyConfig = grunt.config('copy') or {}
		destination = resource.dest or './' + resource.name + '/'
		uniqueName = taskName + '-' + taskNumber + '-' + resource.name
		copyOptionsFiles = [
				cwd: srcFolder
				src: '**'
				dest: destination
				expand: true
			]
		copyConfig[uniqueName] = {}
		copyConfig[uniqueName].files = copyOptionsFiles
		grunt.config('copy', copyConfig)
		grunt.task.run 'copy:' + uniqueName
		grunt.verbose.oklns "With range " + resource.range + ", " + srcFolder + " queued to copy to " + destination
		
	grunt.registerMultiTask  'semverCopy', 'Copies the contents of a folder named with Semantic Versioning', () ->
		#raw resources object/object array
		dataResources = @data.resources

		#json file path(s) to look for resources object/object arrays
		resourcesFiles = @data.resourcesFiles

		queueSemVerFolderCopy (resolveMaxSemVerFolder resource), resource, @name, i for resource, i in parseResources(dataResources, resourcesFiles)

			
