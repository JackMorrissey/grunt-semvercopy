# grunt-semverCopy [![Build Status](https://api.travis-ci.org/JackMorrissey/grunt-semverCopy.png?branch=master)](https://travis-ci.org/JackMorrissey/grunt-semverCopy)

> Identifies and copies the contents of a folder named with Semantic Versioning

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-semverCopy --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-semverCopy');
```

## The "semverCopy" task

### Overview
In your project's Gruntfile, add a section named `semverCopy` to the data object passed into `grunt.initConfig()`. semverCopy is a [multi-task](http://gruntjs.com/configuring-tasks#task-configuration-and-targets).

```js
grunt.initConfig({
	semverCopy: {
		taskTarget: {
			resources: {
					name: "ResourceName",
					range: "~1.1.1",
					parentDirectory: "//NETWORK/Path/To/Parent/",
					dest: './Destination/Path/'
			}
		}
	},
})
```

### Resource Object

#### name
Type: `string`

The name of the resource you would like to pull in.

#### range
Type: `string`

A valid [SemVer](http://semver.org/) range used to identify the max SemVer folder. See [node-semver](https://github.com/isaacs/node-semver/blob/master/README.md#ranges) for supported ranges.

#### parentDirectory
Type: `string`

The path to the parent directory of the SemVer named folders.

#### dest
Type: `string`
Default value: `./{name}/`

The destination folder to copy the contents of the max SemVer folder.

## Simple Sample Scenario

You have an external dependency on a CoreAPI which is organized on disk into SemVer named folders.

* //NETWORK/CoreAPI/1.0.0/
* //NETWORK/CoreAPI/1.1.0/
* //NETWORK/CoreAPI/1.1.1/
* //NETWORK/CoreAPI/1.1.2/
* //NETWORK/CoreAPI/2.0.0/

You would like to copy the contents of version ~1.1 into your current project in the location `./resources/api/`.

A possible gruntfile could look like - 

```js
grunt.initConfig({
	semverCopy: {
		development: {
			resources: {
				name: "CoreAPI",
				range: "~1.1",
				parentDirectory: "//NETWORK/CoreAPI/",
				dest: './resources/api/'
			}
		}
	},
})
```

When run, the contents of `//NETWORK/CoreAPI/1.1.2/` will be copied into `./resources/api/`.

## Usage Examples

Resources can either be place directly in the gruntfile config or configured from within a JSON file. When multiple resources are found, every resource is acted upon naive of others that have or will run.

Single Object 

```js
grunt.initConfig({
	semverCopy: {
		taskTarget: {
			resources: {
				name: "ResourceName",
				range: "~1.1.1",
				parentDirectory: "//NETWORK/Path/To/Parent/",
				dest: 'Optional/Destination/Path'
			}
		}
	},
})
```

Single JSON file

```js
grunt.initConfig({
	semverCopy: {
		taskTarget: {
			resourcesFiles: 'path/to/someFile.json'
		}
	},
})
```

Multiple Objects

```js
grunt.initConfig({
	semverCopy: {
		taskTarget: {
			resources: {
				name: "ResourceName",
				range: "~1.1.1",
				parentDirectory: "//NETWORK/Path/To/Parent/",
				dest: 'Optional/Destination/Path'
			},{
				name: "AnotherResourceName",
				range: "~1.1.1",
				parentDirectory: "//NETWORK/Path/To/AnotherParent/",
				dest: 'AnotherOptional/Destination/Path'
			}
		}
	},
})
```

Multiple JSON files

```js
grunt.initConfig({
	semverCopy: {
		taskTarget: {
			resourcesFiles: ['path/to/someFile.json', 'path/to/anotherFile.json']
		}
	},
})
```

In the above examples, resourceFiles are valid json files that contain the resources object/array.

### Sample JSON file contents

Single Objects

```js
{
	"resources": {
		"name": "ResourceName",
		"range": "~1.1.1",
		"parentDirectory": "//NETWORK/Path/To/Parent/"
	}
}
```

Multiple Objects

```js
{
	"resources": [
		{
			"name": "ResourceName",
			"range": "~1.1.1",
			"parentDirectory": "//NETWORK/Path/To/Parent/"
		},{
			"name": "AnotherResourceName",
			"range": "~1.1.1",
			"parentDirectory": "//NETWORK/Path/To/AnotherParent/"
		}
	]
}
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Test your code using [Grunt](http://gruntjs.com/).

## Release History
_(Nothing yet)_
