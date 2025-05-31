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
            var username = buffer_read(argument0, buffer_string);
            var tx = buffer_read(argument0, buffer_u16);
            var ty = buffer_read(argument0, buffer_u16);
            var is_teacher = buffer_read(argument0, buffer_u8);

            var foundPlayer = -1;

            with (obj_Network_Player) {
                if (name == username) {
                    foundPlayer = id;
                }
            }
            
            with (obj_Network_Teacher) {
                if (name == username) {
                    foundPlayer = id;
                }
            }

            if (foundPlayer != -1) {
                with (foundPlayer) {
                    target_x = tx;
                    target_y = ty;
                }
            } else {
                var player_obj = is_teacher == 1 ? obj_Network_Teacher : obj_Network_Player;
                var inst = instance_create_depth(tx, ty, 1, player_obj);
                inst.name = username;
            }
            break;

        case "USER_DATA":
            var nome = buffer_read(argument0, buffer_string);
            var sobrenome1 = buffer_read(argument0, buffer_string);
            var sobrenome2 = buffer_read(argument0, buffer_string);
            var email = buffer_read(argument0, buffer_string);
            var nascimento_original = buffer_read(argument0, buffer_string);
            var is_prof = buffer_read(argument0, buffer_u8);

            var partes = string_split(nascimento_original, "-");
            var nascimento_formatado;
            if (array_length(partes) == 3) {
                nascimento_formatado = partes[2] + "-" + partes[1] + "-" + partes[0];
            } else {
                nascimento_formatado = nascimento_original;
            }

            txt_Name.text = nome;
            txt_Lastname1.text = sobrenome1;
            txt_Lastname2.text = sobrenome2;
            txt_Email.text = email;
            txt_Birth.text = nascimento_formatado;
            chk_Teacher.checked = (is_prof == 1);
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

        case "SIT":
            var username = buffer_read(argument0, buffer_string);
            var chair_id = buffer_read(argument0, buffer_u16);

            show_debug_message("[REDE] SIT recebido de " + username + " para cadeira " + string(chair_id));

            // Verifica tanto jogadores quanto professores
            with (obj_Network_Player) {
                if (name == username) {
                    is_sitting = true;
            
                    // Move para a cadeira
                    with (obj_Table) {
                        if (chair_uid == chair_id) {
                            other.x = x - 16;
                            other.y = y - 16;
                        }
                    }
					
					with (obj_Chair) {
                        if (chair_uid == chair_id) {
                            other.x = x - 16;
                            other.y = y - 16;
                        }
                    }
            
                    show_debug_message(">>> SIT aplicado para jogador " + name);
                }
            }
    
            with (obj_Network_Teacher) {
                if (name == username) {
                    is_sitting = true;
            
                    // Move para a cadeira (posição pode ser diferente para professores)
                    with (obj_Teacher_Table) {
                        if (chair_uid == chair_id) {
                            other.x = x + 13;
                            other.y = y - 18;
                        }
                    }
            
                    sprite_index = spr_Teacher_Sitting;
                    image_speed = 1;
            
                    show_debug_message(">>> SIT aplicado para professor " + name);
                }
            }
            break;

        case "STAND":
            var username = buffer_read(argument0, buffer_string);

            show_debug_message("[REDE] STAND recebido de " + username);

            // Para jogadores
            with (obj_Network_Player) {
                if (name == username) {
                    is_sitting = false;
                    chair_id = -1;

                    if (variable_instance_exists(id, "prev_x") && variable_instance_exists(id, "prev_y")) {
                        x = prev_x;
                        y = prev_y;
                    }

                    switch (last_direction) {
                        case "left": sprite_index = spr_Student_Iddle_Left; break;
                        case "right": sprite_index = spr_Student_Iddle_Right; break;
                        case "up": sprite_index = spr_Student_Iddle_Up; break;
                        case "down": sprite_index = spr_Student_Iddle_Down; break;
                        default: sprite_index = sprite_standing; break;
                    }
                    image_speed = 1;

                    show_debug_message(">>> STAND aplicado para jogador " + name);
                }
            }
    
            // Para professores
            with (obj_Network_Teacher) {
                if (name == username) {
                    is_sitting = false;
                    chair_id = -1;

                    if (variable_instance_exists(id, "prev_x") && variable_instance_exists(id, "prev_y")) {
                        x = prev_x;
                        y = prev_y;
                    }

                    switch (last_direction) {
                        case "left": sprite_index = spr_Teacher_Iddle_Left; break;
                        case "right": sprite_index = spr_Teacher_Iddle_Right; break;
                        case "up": sprite_index = spr_Teacher_Iddle_Up; break;
                        case "down": sprite_index = spr_Teacher_Iddle_Down; break;
                        default: sprite_index = sprite_teacher_standing; break;
                    }
                    image_speed = 1;

                    show_debug_message(">>> STAND aplicado para professor " + name);
                }
            }
            break;
			
		case "CHAT":
		    var username = buffer_read(argument0, buffer_string);
		    var msg = buffer_read(argument0, buffer_string);
			with (obj_ChatBox) {
			    array_push(chat_log, username + ": " + msg);
			    if (!chat_expanded) {
			        has_new_message = true;
			    }
			}
		    break;	
			
		case "DOOR":
		    var door_id = buffer_read(argument0, buffer_string);
		    var action = buffer_read(argument0, buffer_string);
		    show_debug_message("[REDE] Porta " + door_id + " -> " + action);

		    with (obj_Door) {
		        if (string(id) == door_id) {
		            if (action == "OPEN" && door_state == "closed") {
		                sprite_index = spr_Door_Open;
		                image_index = 0;
		                image_speed = 1;
		                door_state = "opening";
		            }
		            else if (action == "CLOSE" && door_state == "open") {
		                sprite_index = spr_Door_Close;
		                image_index = 0;
		                image_speed = 1;
		                door_state = "closing";
		                solid = true;
		            }
		        }
		    }
		    break;


    }
}