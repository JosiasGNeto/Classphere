if (!is_player_sitting && instance_exists(obj_Player)) {
    if (point_distance(x, y, obj_Player.x, obj_Player.y) < interaction_range) {
        is_player_sitting = true;
        player_sitting = obj_Player.id;
        
        with (obj_Player) {
            visible = false;
            active = false;
            moving = false;
            sit_original_x = x;
            sit_original_y = y;
			
			// Envia pacote SIT com a posição da cadeira
			var sit_packet = buffer_create(256, buffer_grow, 1);
			buffer_write(sit_packet, buffer_string, "SIT");
			buffer_write(sit_packet, buffer_f32, other.x);
			buffer_write(sit_packet, buffer_f32, other.y);
			network_write(Network.socket, sit_packet);
        }
        
        sitting_sprite = instance_create_layer(x + sprite_xoff, y + sprite_yoff, layer, obj_Player_Sitting);
        sitting_sprite.depth = depth - 1;

        // Se quiser, guarde o dono para controle futuro
        sitting_sprite.owner = player_sitting;
    }
}
