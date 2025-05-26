// Dessentar com espaço (só quem sentou pode levantar)
if (is_player_sitting && keyboard_check_pressed(vk_space)) {
    is_player_sitting = false;
    
    if (instance_exists(player_sitting)) {
        with (player_sitting) {
            visible = true;
            active = true;
            moving = false;
            x = sit_original_x;
            y = sit_original_y;
            target_x = x;
            target_y = y;
			
			// Envia pacote UNSIT
			var unsit_packet = buffer_create(256, buffer_grow, 1);
			buffer_write(unsit_packet, buffer_string, "UNSIT");
			network_write(Network.socket, unsit_packet);
        }
    }
    
    if (instance_exists(sitting_sprite)) {
        instance_destroy(sitting_sprite);
    }
}
