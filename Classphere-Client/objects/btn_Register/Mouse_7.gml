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
	    var dd = real(string_copy(raw_birth, 1, 2));
	    var mm = real(string_copy(raw_birth, 4, 2));
	    var yyyy = real(string_copy(raw_birth, 7, 4));
    
	    var dias_no_mes = [31,28,31,30,31,30,31,31,30,31,30,31];

	    // Verifica ano bissexto
	    if ((yyyy mod 4 == 0 && yyyy mod 100 != 0) || (yyyy mod 400 == 0)) {
	        dias_no_mes[1] = 29;
	    }

	    // Validações
	    if (mm >= 1 && mm <= 12 && dd >= 1 && dd <= dias_no_mes[mm - 1]) {
	        var converted_birth = string(yyyy) + "-" + string_format(mm, 2, 0) + "-" + string_format(dd, 2, 0);
	        buffer_write(register_packet, buffer_string, converted_birth);
	    } else {
	        show_message("Erro: Data inválida. Verifique o dia e o mês.");
	        buffer_delete(register_packet);
	        return;
	    }

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
