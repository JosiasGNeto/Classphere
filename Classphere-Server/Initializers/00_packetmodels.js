var Parser = require('binary-parser').Parser;
var StringOptions = { length: 99, zeroTerminated: true };

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
        .string("nascimento", StringOptions)
        .uint8("professor"),

    pos: new Parser().skip(1)
        .string("command", StringOptions)
        .int32le("target_x")
        .int32le("target_y"),

    get_user_by_rg: new Parser().skip(1)
        .string("command", StringOptions)
        .string("rg", StringOptions),

    update_user: new Parser().skip(1)
        .string("command", StringOptions)
        .string("rg", StringOptions)
        .string("nome", StringOptions)
        .string("sobrenome1", StringOptions)
        .string("sobrenome2", StringOptions)
        .string("email", StringOptions)
        .string("nascimento", StringOptions)
        .uint8("professor"),

    delete_user: new Parser().skip(1)
        .string("command", StringOptions)
        .string("rg", StringOptions),
    
    sit: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions)
        .uint16le("chair_uid"),

    stand: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions),
        
    chat: new Parser().skip(1)
        .string("command", StringOptions)
        .string("username", StringOptions)
        .string("message", StringOptions),
};
