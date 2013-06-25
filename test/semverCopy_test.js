var grunt = require('grunt');
var fs = require('fs');

exports.copy = {
	inlineResource: function(test) {
		'use strict';

		test.expect(1);

		var actual = fs.readdirSync('tmp/inlineResource').sort();
		var expected = fs.readdirSync('test/expected/inlineResource').sort();
		test.deepEqual(expected, actual, 'should copy several files via inlineResource');

		test.done();
	},

	inlineResources: function(test) {
		'use strict';

		test.expect(1);

		var actual = fs.readdirSync('tmp/inlineResources').sort();
		var expected = fs.readdirSync('test/expected/inlineResources').sort();
		test.deepEqual(expected, actual, 'should copy several files via inlineResources');

		test.done();
	},

	JSONResource: function(test) {
		'use strict';

		test.expect(1);

		var actual = fs.readdirSync('tmp/JSONResource').sort();
		var expected = fs.readdirSync('test/expected/JSONResource').sort();
		test.deepEqual(expected, actual, 'should copy several files via JSONResource');

		test.done();
	},

	JSONResources: function(test) {
		'use strict';

		test.expect(1);

		var actual = fs.readdirSync('tmp/JSONResources').sort();
		var expected = fs.readdirSync('test/expected/JSONResources').sort();
		test.deepEqual(expected, actual, 'should copy several files via JSONResources');

		test.done();
	}
};