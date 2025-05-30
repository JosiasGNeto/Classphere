var zeroBuffer = new Buffer.from('00', 'hex');

module.exports = packet = {

    //params: an array of JS objects to be turned into buffers.
    build: function(params) {
        var packetParts = [];
        var packetSize = 0;

        params.forEach(function(param) {
            var buffer;

            if (typeof param === 'string') {
                buffer = Buffer.from(param, 'utf8');
                buffer = Buffer.concat([buffer, zeroBuffer], buffer.length + 1);
            }
            else if (typeof param === 'number') {
                buffer = Buffer.alloc(2);
                buffer.writeUInt16LE(param, 0);
            }
            else {
                console.log("WARNING: Unknown data type in packet builder!", param);
                // Para evitar erro, crie um buffer vazio ou de tamanho 0:
                buffer = Buffer.alloc(0);
            }

            packetSize += buffer.length;
            packetParts.push(buffer);
        });

        var dataBuffer = Buffer.concat(packetParts, packetSize);

        var size = Buffer.alloc(1);
        size.writeUInt8(dataBuffer.length + 1, 0);

        var finalPacket = Buffer.concat([size, dataBuffer], size.length + dataBuffer.length);

        return finalPacket;
    },


    //Parse a packet to be handled for a client
    parse: function(c, data){
        var idx = 0;
        while(idx < data.length){
            var packetSize = data.readUInt8(idx);

            // Verifica se o pacote está totalmente contido no buffer:
            if (idx + packetSize > data.length) {
                console.warn("Pacote incompleto recebido, descartando...");
                break; // ou retorne, ignore o restante, etc.
            }

            var extractedPacket = Buffer.alloc(packetSize);
            data.copy(extractedPacket, 0, idx, idx + packetSize);

            this.interpret(c, extractedPacket);

            idx += packetSize;
        }
    },


    interpret: async function(c, datapacket){

        var header = PacketModels.header.parse(datapacket);
        console.log("Interpret: " + header.command);

        switch(header.command.toUpperCase()){

            case "LOGIN":
                var data = PacketModels.login.parse(datapacket);
                User.login(data.username, data.password, function(result, user) {
                    if (result) {
                        c.user = user;
                        c.enterroom(c.user.current_room);

                        const is_admin = user.adm ? 1 : 0;
                        const is_teacher = user.professor ? 1 : 0;

                        c.socket.write(packet.build([
                            "LOGIN",
                            "TRUE",
                            c.user.current_room,
                            c.user.pos_x,
                            c.user.pos_y,
                            c.user.username,
                            is_admin,
                            is_teacher
                        ]));
                    } else {
                        c.socket.write(packet.build(["LOGIN", "FALSE"]));
                    }
                });
                break;



            case "REGISTER":
                var data = PacketModels.register.parse(datapacket);
                User.register(
                    data.username,
                    data.email,
                    data.rg,
                    data.nome,
                    data.sobrenome1,
                    data.sobrenome2,
                    data.nascimento,
                    data.professor === 1,
                    data.adm === 1,
                    function(result) {
                        if (result) {
                            c.socket.write(packet.build(["REGISTER", "TRUE"]));
                        } else {
                            c.socket.write(packet.build(["REGISTER", "FALSE"]));
                        }
                    }
                );
                break;


            case "POS":
                var data = PacketModels.pos.parse(datapacket);
                const is_teacher = c.user.professor ? 1 : 0;
                c.user.pos_x = data.target_x;
                c.user.pos_y = data.target_y;
            
                if (c.user._isSaving) break;
            
                c.user._isSaving = true;
                c.user.save()
                    .then(() => {
                        c.user._isSaving = false;
                    })
                    .catch((err) => {
                        console.error("Erro ao salvar usuário:", err);
                        c.user._isSaving = false;
                    });
            
                c.broadcastroom(packet.build(["POS", c.user.username, data.target_x, data.target_y, is_teacher]));
                console.log(data);
                break;

            case "USER_DATA":
                var data = PacketModels.get_user_by_rg.parse(datapacket);
                User.getByRG(data.rg, (success, user) => {
                    if (success && user) {
                        // Garanta que todos os campos são strings ou números válidos
                        var nome = user.nome || "";
                        var sobrenome1 = user.sobrenome1 || "";
                        var sobrenome2 = user.sobrenome2 || "";
                        var email = user.email || "";
                        var nascimento = user.nascimento || "";
                        var professor = user.professor ? 1 : 0;

                        var nascimentoStr = "";

                        if (user.nascimento) {
                            // Se for objeto Date, converte para string
                            if (user.nascimento instanceof Date) {
                                nascimentoStr = user.nascimento.toISOString().substring(0, 10); // YYYY-MM-DD
                            } else {
                                nascimentoStr = String(user.nascimento);
                            }
                        }

                        c.socket.write(packet.build([
                            "USER_DATA",
                            nome || "",
                            sobrenome1 || "",
                            sobrenome2 || "",
                            email || "",
                            nascimentoStr,
                            professor ? 1 : 0
                        ]));

                    } else {
                        c.socket.write(packet.build(["USER_NOT_FOUND"]));
                    }
                });
                break;

            case "UPDATE_USER":
                var data = PacketModels.update_user.parse(datapacket);
                User.updateUser(
                    data.rg,
                    {
                        nome: data.nome,
                        sobrenome1: data.sobrenome1,
                        sobrenome2: data.sobrenome2,
                        email: data.email,
                        nascimento: data.nascimento,
                        professor: data.professor === 1
                    },
                    function(result) {
                        if (result) {
                            c.socket.write(packet.build(["UPDATE_USER", "TRUE"]));
                        } else {
                            c.socket.write(packet.build(["UPDATE_USER", "FALSE"]));
                        }
                    }
                );
                break;

            case "DELETE_USER":
                var data = PacketModels.delete_user.parse(datapacket);
                console.log("Tentando deletar RG:", data.rg);
                User.deleteUser(data.rg, function(result) {
                    console.log("Resultado da exclusão:", result);
                    if (result) {
                        c.socket.write(packet.build(["DELETE_USER", "TRUE"]));
                    } else {
                        c.socket.write(packet.build(["DELETE_USER", "FALSE"]));
                    }
                });
                break;
            
            case "SIT":
                var data = PacketModels.sit.parse(datapacket);
                console.log("Interpret: SIT");
                console.log("Valores recebidos:", data);

                c.user.chair_uid = data.chair_uid;

                const pacote = packet.build(["SIT", data.username, data.chair_uid]);
                console.log("Pacote a enviar para broadcast:", pacote);

                c.broadcastroom(pacote);
                break;

            case "STAND":
                console.log("Enviando comando STAND para " + c.user.username);

                // Reenvia para todos os outros jogadores da sala
                c.broadcastroom(packet.build(["STAND", c.user.username]));
                break;

            
            case "CHAT":
                const username = PacketModels.chat.parse(datapacket).username;
                const message = PacketModels.chat.parse(datapacket).message;

                console.log(`[CHAT] ${username}: ${message}`);

                c.broadcastroom(packet.build(["CHAT", username, message]));
                break;

            case "DOOR":
                var data = PacketModels.door.parse(datapacket);
                console.log(`Porta ${data.door_id} -> ${data.action} por ${c.user.username}`);

                // Envia para todos da sala (menos quem enviou)
                c.broadcastroom(
                    packet.build(["DOOR", data.door_id, data.action])
                );
                break;



        }   

    }

}