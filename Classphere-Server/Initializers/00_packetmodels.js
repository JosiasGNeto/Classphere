var Parser = require('binary-parser').Parser
var StringOptions = {length: 99, zeroTerminated:true};

module.exports = PacketModels = {

    header: new Parser().skip(1)
        .string("command", StringOptions),

    login: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions)
        .string("password", StringOptions), 

    register: new Parser().skip(1)
        .string("command", StringOptions)
        .string("email", StringOptions)
        .string("rg", StringOptions)           
        .string("nome", StringOptions)
        .string("sobrenome1", StringOptions)
        .string("sobrenome2", StringOptions)
        .string("nascimento", StringOptions),  

    pos: new Parser().skip(1)
        .string("command", StringOptions)
        .int32le("target_x", StringOptions)
        .int32le("target_y", StringOptions)
}