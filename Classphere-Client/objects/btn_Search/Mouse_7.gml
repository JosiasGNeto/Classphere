if (string_length(txt_RG.text) > 0) {
    var rg_packet = buffer_create(256, buffer_grow, 1);
    buffer_write(rg_packet, buffer_string, "USER_DATA");
    buffer_write(rg_packet, buffer_string, txt_RG.text);
    network_write(Network.socket, rg_packet);
    buffer_delete(rg_packet);
} else {
    show_message("Digite o RG para buscar o usuário.");
}
