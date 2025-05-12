var zeroBuffer = new Buffer.from('00', 'hex');

module.exports = packet = {

    //params: an array of JS objects to be turned into buffers.
    build: function(params){

        var packetParts = [];
        var packetSize = 0;

        params.forEach(function(param){
            var buffer;

            if(typeof param === 'string'){
                buffer = Buffer.from(param, 'utf8');
                buffer = Buffer.concat([buffer, zeroBuffer], buffer.length + 1)
            }
            else if(typeof param === 'number'){
                buffer = Buffer.alloc(2);
                buffer.writeUInt16LE(param, 0);
            }
            else {
                console.log("WARNING: Unknown data type in packet builder!");
            }

            packetSize += buffer.length;
            packetParts.push(buffer);

        })

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
            var extractedPacket = new Buffer.alloc(packetSize);
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
                User.login(data.username, data.password, function(result, user){
                    if(result){
                        c.user = user;
                        c.enterroom(c.user.current_room);
                        c.socket.write(packet.build(["LOGIN", "TRUE", c.user.current_room, c.user.pos_x, c.user.pos_y, c.user.username]))
                    }
                    else{
                        c.socket.write(packet.build(["LOGIN", "FALSE"]))
                    }
                })
                break;

            case "REGISTER":
                
                var data = PacketModels.register.parse(datapacket);    
                User.register(data.username, data.password, function(result){
                    if(result){
                        c.socket.write(packet.build(["REGISTER", "TRUE"]));
                    }
                    else{
                        c.socket.write(packet.build(["REGISTER", "FALSE"]));
                    }
                });

                break;

            case "POS":
                var data = PacketModels.pos.parse(datapacket);
                c.user.pos_x = data.target_x;
                c.user.pos_y = data.target_y;
            
                // Se já está salvando, pula o save atual
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
            
                c.broadcastroom(packet.build(["POS", c.user.username, data.target_x, data.target_y]));
                console.log(data);
                break;
        }   

    }

}