// Argument0: data buffer
function handle_packet() {
    var command = buffer_read(argument0, buffer_string);
    show_debug_message("Networking Event: " + string(command));
    
    switch (command) {
        case "Hello":
            server_time = buffer_read(argument0, buffer_string);
            room_goto_next();
            show_debug_message("Bem vindo! @" + server_time);
            break;
        
		case "LOGIN":
		    status = buffer_read(argument0, buffer_string);
		    if (status == "TRUE") {
		        target_room = buffer_read(argument0, buffer_string);
		        target_x = buffer_read(argument0, buffer_u16);
		        target_y = buffer_read(argument0, buffer_u16);
		        name = buffer_read(argument0, buffer_string);
		        var is_admin = buffer_read(argument0, buffer_u8); 

		        // Verifica se é admin
		        if (is_admin == 1) {
		            room_goto(manage); // substitua pelo nome real da sala de admin
		        } else {
		            room_goto(spawn); // sala normal
							        // Cria o jogador local
			        with (instance_create_depth(target_x, target_y, 1, obj_Player)) {
			            name = other.name;
			        }
		        }

		    } else {
		        show_message("Usuário ou senha incorreto!");
		    }
		    break;

        
        case "REGISTER":
            status = buffer_read(argument0, buffer_string);
            if (status == "TRUE") {
                show_message("Usuário registrado com sucesso!");
            } else {
                show_message("Erro: Usuário já registrado!");
            }
            break;
        
        case "POS":
            username = buffer_read(argument0, buffer_string);
            target_x = buffer_read(argument0, buffer_u16);
            target_y = buffer_read(argument0, buffer_u16);

            foundPlayer = -1;
            with (obj_Network_Player) {
                if (name == other.username) {
                    other.foundPlayer = id;
                }
            }

            if (foundPlayer != -1) {
                with (foundPlayer) {
                    target_x = other.target_x;
                    target_y = other.target_y;
                }
            } else {
                with (instance_create_depth(target_x, target_y, 1, obj_Network_Player)) {
                    name = other.username;
                }
            }
            break;

		case "USER_DATA":
		    var nome        = buffer_read(argument0, buffer_string);
		    var sobrenome1  = buffer_read(argument0, buffer_string);
		    var sobrenome2  = buffer_read(argument0, buffer_string);
		    var email       = buffer_read(argument0, buffer_string);
		    var nascimento_original  = buffer_read(argument0, buffer_string);
		    var is_prof     = buffer_read(argument0, buffer_u8);
    
		    // Assume que o servidor envia YYYY-MM-DD
		    var partes = string_split(nascimento_original, "-");
		    var nascimento_formatado;
		    if (array_length(partes) == 3) {
		        // Converte para DD-MM-YYYY para exibição
		        nascimento_formatado = partes[2] + "-" + partes[1] + "-" + partes[0];
		    } else {
		        nascimento_formatado = nascimento_original;
		    }

		    txt_Name.text        = nome;
		    txt_Lastname1.text   = sobrenome1;
		    txt_Lastname2.text   = sobrenome2;
		    txt_Email.text       = email;
		    txt_Birth.text       = nascimento_formatado;
		    chk_Teacher.checked  = (is_prof == 1);
		    break;


        case "USER_NOT_FOUND":
            show_message("Usuário não encontrado.");
            break;
			
		case "UPDATE_USER":
		    var status = buffer_read(argument0, buffer_string);
		    if (status == "TRUE") {
		        show_message("Usuário atualizado com sucesso!");
		    } else {
		        show_message("Erro ao atualizar o usuário.");
		    }
		    break;
			
		case "DELETE_USER":
		    var status = buffer_read(argument0, buffer_string);
		    if (status == "TRUE") {
		        show_message("Usuário excluído com sucesso!");
		    } else {
		        show_message("Erro ao excluir usuário.");
		    }
		    break;

    }
}
