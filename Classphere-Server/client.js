var now = require('performance-now');
var _ = require('underscore');

module.exports = function(){

    var client = this;

    // Essas propriedades são definidas em runtime
    // this.socket = {}
    // this.user = {}

    this.initiate = function(){
        var client = this;

        // Envia o handshake de conexão
        client.socket.write(packet.build(["Hello", now().toString()]));
        console.log('Client initiated');
    }

    // Método para o cliente entrar numa sala
    this.enterroom = function(selected_room){

        maps[selected_room].clients.forEach(function(otherClient){
            otherClient.socket.write(packet.build(["ENTER", client.user.username, client.user.pos_x, client.user.pos_y]))
        })

        maps[selected_room].clients.push(client);

    }

    // Broadcast para todos da sala, menos ele mesmo
    this.broadcastroom = function(packetData){
        maps[client.user.current_room].clients.forEach(function(otherClient){
            if(otherClient.user.username != client.user.username){
                otherClient.socket.write(packetData);
            }
        })
    };

    // Evento de dados recebidos
    this.data = function(data){
        packet.parse(client, data);
    }

    // Evento de erro na conexão
    this.error = function(err){
        console.log("Client error: " + err.toString());

        // Garante que a limpeza será feita ao ocorrer erro
        client.end();
    }

    // Evento quando o cliente fecha a conexão
    this.end = function(){
        console.log("Client closed: " + (client.user ? client.user.username : "unknown"));

        if(client.user && client.user.current_room && maps[client.user.current_room]){
            // Remove o cliente da lista da sala
            let roomClients = maps[client.user.current_room].clients;
            let index = roomClients.indexOf(client);
            if(index !== -1){
                roomClients.splice(index, 1);
            }

            // Envia para os outros clientes que esse usuário saiu
            const leavePacket = packet.build(["LEAVE", client.user.username]);
            roomClients.forEach(function(otherClient){
                otherClient.socket.write(leavePacket);
            });
        }
    }

}
