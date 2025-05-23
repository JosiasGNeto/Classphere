// Verifique se todos os campos obrigatórios foram preenchidos
if (
    // string_length(txt_Username.text) > 0 &&
    string_length(txt_Email.text) > 0 &&
    string_length(txt_RG.text) > 0 &&
    string_length(txt_Name.text) > 0 &&
    string_length(txt_Lastname1.text) > 0 &&
    string_length(txt_Birth.text) > 0
) {
    // Cria um buffer com tamanho inicial suficiente
    var register_packet = buffer_create(512, buffer_grow, 1);

    // Escreve os dados no buffer na ordem esperada pelo servidor
    buffer_write(register_packet, buffer_string, "REGISTER");
    // buffer_write(register_packet, buffer_string, txt_Username.text);    // username
    buffer_write(register_packet, buffer_string, txt_Email.text);       // email
    buffer_write(register_packet, buffer_string, txt_RG.text);          // rg (também será a senha)
    buffer_write(register_packet, buffer_string, txt_Name.text);        // nome
    buffer_write(register_packet, buffer_string, txt_Lastname1.text);   // sobrenome1

    // 2º sobrenome opcional
    if (string_length(txt_Lastname2.text) > 0) {
        buffer_write(register_packet, buffer_string, txt_Lastname2.text);
    } else {
        buffer_write(register_packet, buffer_string, "");
    }

	var raw_birth = txt_Birth.text;
	if (string_length(raw_birth) == 10 && string_char_at(raw_birth, 3) == "-" && string_char_at(raw_birth, 6) == "-") {
		// Já está no formato DD-MM-YYYY, envia diretamente
		buffer_write(register_packet, buffer_string, raw_birth);
	} else {
		show_message("Erro: Data inválida. Use o formato DD-MM-AAAA.");
		buffer_delete(register_packet);
		return;
	}

	
	var teacher_flag = (chk_Teacher.checked) ? 1 : 0;
    buffer_write(register_packet, buffer_u8, teacher_flag);

    // Envia o pacote para o servidor
    network_write(Network.socket, register_packet);

    // Libera o buffer para evitar vazamento de memória
    buffer_delete(register_packet);
	
	with (ui_textbox_base) {
        text = "";
    }
	
	chk_Teacher.checked = false;

} else {
    show_message("Erro: Todos os campos obrigatórios devem ser preenchidos!");
}
