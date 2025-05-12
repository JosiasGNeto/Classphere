require('dotenv').config(); // Adicione essa linha no topo
var args = require('minimist')(process.argv.slice(2));
var extend = require('extend');

var environment = args.env || "test";

var common_conf = {
    name: "Classphere Server",
    version: "0.0.1",
    environment: environment,
    max_player: 20,
    data_paths: {
        items: __dirname + "/Game Data/Items/",
        maps: __dirname + "/Game Data/Maps/"
    },
    starting_zone: "spawn"
};

var conf = {
    production: {
        ip: args.ip || "0.0.0.0",
        port: args.port || 8081,
        database: process.env.MONGO_URI_PROD
    },

    test: {
        ip: args.ip || "0.0.0.0",
        port: args.port || 8082,
        database: process.env.MONGO_URI_TEST
    }
};

extend(false, conf.production, common_conf);
extend(false, conf.test, common_conf);

module.exports = config = conf[environment];
