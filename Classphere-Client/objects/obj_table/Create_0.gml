// Create Event do obj_Table

if (!variable_global_exists("global_chair_uid_counter")) {
    global.global_chair_uid_counter = 0;
}

chair_uid = global.global_chair_uid_counter;
global.global_chair_uid_counter += 1;

occupant_id = -1;  
occupied = false;

show_press_e = false;


function Sit(player) {
    if (!occupied) {
        occupied = true;
        occupant_id = player.id;
        player.is_sitting = true;
        player.chair_id = id;
		
		player.prev_x = player.x;
		player.prev_y = player.y;
		
        player.x = x - 16;
        player.y = y - 16;
		
		var buffer = buffer_create(256, buffer_grow, 1);
		buffer_write(buffer, buffer_string, "SIT");
		buffer_write(buffer, buffer_string, Network.username);
		buffer_write(buffer, buffer_u16, chair_uid); // ID da cadeira
		network_write(Network.socket, buffer);
		buffer_delete(buffer);

        return true;
    }
    return false;
}

function Stand(player) {
    if (occupied && occupant_id == player.id) {
        occupied = false;
        occupant_id = -1;
        player.is_sitting = false;
        player.chair_id = -1;
        player.x = player.prev_x;
        player.y = player.prev_y;
		
		var buffer = buffer_create(256, buffer_grow, 1);
		buffer_write(buffer, buffer_string, "STAND");
		buffer_write(buffer, buffer_string, Network.username);
		network_write(Network.socket, buffer);
		buffer_delete(buffer);

        return true;
    }
    return false;
}
