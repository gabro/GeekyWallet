var parser = require("./parser.js");

var fs = require('fs'),
    filename = "test";

fs.readFile(filename, 'utf8', function(err, data) {
  if (err) throw err;
  var res = parser.parse(data);
  console.log(JSON.stringify(res, null, 2));
});