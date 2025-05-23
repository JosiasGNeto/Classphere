if (string_length(txt_RG.text) == 0) {
    show_message("Digite um RG válido para excluir!");
    return;
}

if (!show_question("Tem certeza que deseja excluir este usuário?")) {
    return;
}

var packet = buffer_create(256, buffer_grow, 1);
buffer_write(packet, buffer_string, "DELETE_USER");
buffer_write(packet, buffer_string, txt_RG.text);
network_write(Network.socket, packet);
buffer_delete(packet);

// Limpa os campos de texto após a exclusão
with (ui_textbox_base) {
    text = "";
}
chk_Teacher.checked = false; // Se aplicável, também reseta o checkbox
