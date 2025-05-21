if (
	string_length(txt_RG.text) == 0 ||
	string_length(txt_Name.text) == 0 ||
	string_length(txt_Lastname1.text) == 0 ||
	string_length(txt_Email.text) == 0 ||
	string_length(txt_Birth.text) == 0
) {
	show_message("Preencha todos os campos obrigatórios!");
	return;
}

var packet = buffer_create(512, buffer_grow, 1);
buffer_write(packet, buffer_string, "UPDATE_USER");
buffer_write(packet, buffer_string, txt_RG.text);
buffer_write(packet, buffer_string, txt_Name.text);
buffer_write(packet, buffer_string, txt_Lastname1.text);
buffer_write(packet, buffer_string, txt_Lastname2.text);
buffer_write(packet, buffer_string, txt_Email.text);
buffer_write(packet, buffer_string, txt_Birth.text);
buffer_write(packet, buffer_u8, chk_Teacher.checked ? 1 : 0);

network_write(Network.socket, packet);
buffer_delete(packet);