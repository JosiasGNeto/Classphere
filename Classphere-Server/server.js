//Import Required Libraries
const config = require(__dirname + "/Resources/config.js");
const fs = require('fs');
const net = require('net');
require('./packet.js')

// console.log(config.database); //-> Debug Database

//1. Load the initializers
var init_files = fs.readdirSync(__dirname + "/Initializers");
init_files.forEach(function(initFile){
    console.log('Loading Initializer: ' + initFile);
    require(__dirname + "/Initializers/" + initFile);
});

//2. Load data models
var model_files = fs.readdirSync(__dirname + "/Models");
model_files.forEach(function(modelFile){
    console.log('Loading Model: ' + modelFile);
    require(__dirname + "/Models/" + modelFile);
});

//3. Load game maps data
maps = {};

var map_files = fs.readdirSync(config.data_paths.maps);
map_files.forEach(function(mapFile){
    console.log('Loading Map: ' + mapFile);
    var map = require(config.data_paths.maps + mapFile);
    maps[map.room] = map
});

// console.log(maps); //-> Debug Maps

net.createServer(function(socket){

    console.log("Socket connected");
    var c_inst = new require('./client.js');
    var thisClient = new c_inst();

    thisClient.socket = socket;
    thisClient.initiate();

    socket.on('error', thisClient.error);

    socket.on('end', thisClient.end);

    socket.on('data', thisClient.data);

}).listen(config.port);

console.log("Initialize Completed!")
console.log("Server running on port: " + config.port)
console.log("For environment: " + config.environment)
//4. Initiate the server
    //-> All server logic