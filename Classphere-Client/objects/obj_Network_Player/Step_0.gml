var dx = target_x - x;
var dy = target_y - y;
var dist = point_distance(x, y, target_x, target_y);

if (dist > 1) {
    var dir = point_direction(x, y, target_x, target_y);
    var move_speed = min(4, dist); // evitar ultrapassar
    x += lengthdir_x(move_speed, dir);
    y += lengthdir_y(move_speed, dir);
} else {
    x = target_x;
    y = target_y;
}
