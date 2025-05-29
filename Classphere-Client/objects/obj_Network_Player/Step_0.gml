if (is_sitting) {
    sprite_index = sprite_sitting;
    image_speed = 1;
    show_debug_message("Sentou");
} else {
    var dx = target_x - x;
    var dy = target_y - y;
    var move_speed = 2;
    var dist = point_distance(x, y, target_x, target_y);

    if (dist > 1) {
        if (dist < move_speed) {
            x = target_x;
            y = target_y;
        } else {
            var dir = point_direction(x, y, target_x, target_y);
            x += lengthdir_x(move_speed, dir);
            y += lengthdir_y(move_speed, dir);
        }

        image_speed = 1;
        
        if (abs(dx) > abs(dy)) {
            if (dx > 0) {
                last_direction = "right";
                sprite_index = spr_Student_Walking_Right;
            } else {
                last_direction = "left";
                sprite_index = spr_Student_Walking_Left;
            }
        } else {
            if (dy > 0) {
                last_direction = "down";
                sprite_index = spr_Student_Walking_Down;
            } else {
                last_direction = "up";
                sprite_index = spr_Student_Walking_Up;
            }
        }
    } else {
        switch (last_direction) {
            case "left": sprite_index = spr_Student_Iddle_Left; break;
            case "right": sprite_index = spr_Student_Iddle_Right; break;
            case "up": sprite_index = spr_Student_Iddle_Up; break;
            case "down": sprite_index = spr_Student_Iddle_Down; break;
            default: sprite_index = default_sprite; break;
        }
        image_speed = 1;
    }
}