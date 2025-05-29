// Create Event do obj_Table

if (!variable_global_exists("global_chair_uid_counter")) {
    global.global_chair_uid_counter = 0;
}

chair_uid = global.global_chair_uid_counter;
global.global_chair_uid_counter += 1;

occupant_id = -1;  
occupied = false;


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
        return true;
    }
    return false;
}
