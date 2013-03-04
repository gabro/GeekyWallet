var parser = require("./parser.js");

var fs = require('fs'),
    filename = process.argv[2];
if (!filename) filename='test'; //fallback

fs.readFile(filename, 'utf8', function(err, data) {
  if (err) throw err;
  var res = parser.parse(data);
  console.log(JSON.stringify(res, null, 2));
});
