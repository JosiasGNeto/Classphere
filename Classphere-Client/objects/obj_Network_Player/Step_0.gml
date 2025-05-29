// Jogador andando ou parado normalmente
var dx = target_x - x;
var dy = target_y - y;
var move_speed = 4;

if (point_distance(x, y, target_x, target_y) > 1) {
    if (abs(dx) > abs(dy)) {
        x += clamp(dx, -move_speed, move_speed);
        if (dx > 0) {
            last_direction = "right";
            sprite_index = spr_Student_Walking_Right;
        } else {
            last_direction = "left";
            sprite_index = spr_Student_Walking_Left;
        }
    } else {
        y += clamp(dy, -move_speed, move_speed);
        if (dy > 0) {
            last_direction = "down";
            sprite_index = spr_Student_Walking_Down;
        } else {
            last_direction = "up";
            sprite_index = spr_Student_Walking_Up;
        }
    }
    image_speed = 1;
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

