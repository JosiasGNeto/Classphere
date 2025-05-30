const Parser = require('binary-parser').Parser;

module.exports = PacketModels = {

    header: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true }),

    login: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("username", { zeroTerminated: true })
        .string("password", { zeroTerminated: true }),

    register: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("email", { zeroTerminated: true })
        .string("rg", { zeroTerminated: true })
        .string("nome", { zeroTerminated: true })
        .string("sobrenome1", { zeroTerminated: true })
        .string("sobrenome2", { zeroTerminated: true })
        .string("nascimento", { zeroTerminated: true })
        .uint8("professor"),

    pos: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .int32le("target_x")
        .int32le("target_y"),

    get_user_by_rg: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("rg", { zeroTerminated: true }),

    update_user: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("rg", { zeroTerminated: true })
        .string("nome", { zeroTerminated: true })
        .string("sobrenome1", { zeroTerminated: true })
        .string("sobrenome2", { zeroTerminated: true })
        .string("email", { zeroTerminated: true })
        .string("nascimento", { zeroTerminated: true })
        .uint8("professor"),

    delete_user: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("rg", { zeroTerminated: true }),

    sit: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("username", { zeroTerminated: true })
        .uint16le("chair_uid"),

    stand: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("username", { zeroTerminated: true }),

    chat: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("username", { zeroTerminated: true })
        .string("message", { zeroTerminated: true }),

    door: new Parser()
        .skip(1)
        .string("command", { zeroTerminated: true })
        .string("door_id", { zeroTerminated: true })
        .string("action", { zeroTerminated: true }),

};
