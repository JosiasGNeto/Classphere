if (chat_active) {
    if (string_length(chat_input) > 0) {
        // Enviar mensagem para o servidor
        var buffer = buffer_create(1024, buffer_grow, 1);
        buffer_write(buffer, buffer_string, "CHAT");
        buffer_write(buffer, buffer_string, Network.username);
        buffer_write(buffer, buffer_string, chat_input);
        network_write(Network.socket, buffer);
        buffer_delete(buffer);

        // Adiciona ao próprio log
        array_push(chat_log, Network.username + ": " + chat_input);

        // Limpa o input
        chat_input = "";
    }

    chat_active = false;
    global.chat_active = false; // Fecha o chat
} else {
    chat_active = true;  // Abre o chat para digitar
    global.chat_active = true;
}
