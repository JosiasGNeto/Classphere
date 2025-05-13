var dx = target_x - x;
var dy = target_y - y;

var move_speed = 4;

if (abs(dx) > 0 || abs(dy) > 0) {
    // Prioriza movimento em X se houver distância
    if (abs(dx) > abs(dy)) {
        x += clamp(dx, -move_speed, move_speed);
    } else {
        y += clamp(dy, -move_speed, move_speed);
    }
}
