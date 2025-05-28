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
		        Network.username = name;

		        var is_admin = buffer_read(argument0, buffer_u16);
		        var is_teacher = buffer_read(argument0, buffer_u16);


		        if (is_admin == 1) {
		            room_goto(manage);
		        } else {
		            room_goto(spawn);

		            var player_obj = is_teacher == 1 ? obj_Teacher : obj_Player;

		            with (instance_create_depth(target_x, target_y, 1, player_obj)) {
						show_debug_message("is_teacher = " + string(is_teacher));

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
		    username    = buffer_read(argument0, buffer_string);
		    target_x    = buffer_read(argument0, buffer_u16);
		    target_y    = buffer_read(argument0, buffer_u16);
		    is_teacher  = buffer_read(argument0, buffer_u8); // <- novo campo vindo do servidor

		    // Primeiro tenta encontrar se o jogador já existe na sala
		    foundPlayer = -1;
		    with (obj_Network_Player) {
		        if (name == other.username) {
		            other.foundPlayer = id;
		        }
		    }
		    with (obj_Network_Teacher) {
		        if (name == other.username) {
		            other.foundPlayer = id;
		        }
		    }

		    // Se encontrou, atualiza a posição
		    if (foundPlayer != -1) {
		        with (foundPlayer) {
		            target_x = other.target_x;
		            target_y = other.target_y;
		        }
		    } 
		    // Senão, cria com o objeto correto com base em is_teacher
		    else {
		        var player_obj = is_teacher == 1 ? obj_Network_Teacher : obj_Network_Player;

		        with (instance_create_depth(target_x, target_y, 1, player_obj)) {
		            name = other.username;
		        }
		    }
		    break;


		case "SIT":
		    var username = buffer_read(argument0, buffer_string);
		    var sit_x = buffer_read(argument0, buffer_f32);
		    var sit_y = buffer_read(argument0, buffer_f32);

		    var found = noone;
		    with (obj_Network_Player) {
		        if (name == username) {
		            found = id; // armazena a referência à instância encontrada
		        }
		    }

		    if (found != noone) {
		        with (found) {
		            visible = false;
		            is_sitting = true;

		            var sit_sprite = instance_create_layer(sit_x, sit_y, "Instances", obj_Player_Sitting);
		            sit_sprite.depth = depth - 1;
		            sit_sprite.x = sit_x + 11;
		            sit_sprite.y = sit_y + 9;
		            sit_sprite.owner = id; // usa o id da própria instância
		        }
		    }
		    break;


		case "UNSIT":
		    var username = buffer_read(argument0, buffer_string);

		    var found = noone;
		    with (obj_Network_Player) {
		        if (name == username) {
		            found = id;
		        }
		    }

		    if (found != noone) {
		        with (found) {
		            visible = true;
		            is_sitting = false;
		        }

		        with (obj_Player_Sitting) {
		            if (owner == found) {
		                instance_destroy();
		            }
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

            var partes = string_split(nascimento_original, "-");
            var nascimento_formatado;
            if (array_length(partes) == 3) {
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
