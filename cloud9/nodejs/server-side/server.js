/*var http = require('http');
http.createServer(function (req, res) {
  debugger;
  console.log("Starting server...");
  res.writeHead(200, {'Content-Type': 'text/plain'});
  console.log("Server started!");
  res.end('Hello World from Cloud9\n');
}).listen(process.env.PORT);*/


function addVars (first, second) {
  var sum = first + second;
  return sum;
}

var firstVar = 2;
var secondVar = 3;

var total = addVars(firstVar, secondVar);

console.log(total);