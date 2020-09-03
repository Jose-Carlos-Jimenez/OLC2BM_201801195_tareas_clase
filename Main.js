var fs = require('fs');
var parser = require('./Grammar');

fs.readFile('./input.txt', (err,data) =>
{
    if(err) throw err;
    console.log("Entrada: " + data.toString());
    var ast = parser.parse(data.toString());
    console.log("Codigo 3D:\n"+ast.c3d.toString());
});