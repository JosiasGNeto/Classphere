event_inherited();

if(string_length(txt_Username.text) > 0 && string_length(txt_Password.text) > 0){
	
	var login_packet = buffer_create(1, buffer_grow, 1);
	buffer_write(login_packet, buffer_string, "login");
	buffer_write(login_packet, buffer_string, txt_Username.text);
	buffer_write(login_packet, buffer_string, txt_Password.text);

	network_write(Network.socket, login_packet);
	
}
else{
	show_message("Erro: O usuário ou a senha não podem estar vazios!");
}
