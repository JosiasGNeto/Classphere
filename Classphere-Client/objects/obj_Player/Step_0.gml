// =========================
// Step Event do personagem
// =========================

var dx = target_x - x;
var dy = target_y - y;

// Movimento em direção ao alvo
if (moving) {
    var dist = point_distance(x, y, target_x, target_y);
    
    if (dist < 4) {
        x = target_x;
        y = target_y;
        moving = false;
    } else {
        var dir = point_direction(x, y, target_x, target_y);
        x += lengthdir_x(4, dir);
        y += lengthdir_y(4, dir);
    }
}

// Entrada de teclado (só quando não está se movendo)
if (!moving) {
    var moved = false;
    var new_x = target_x;
    var new_y = target_y;

    if (keyboard_check(ord("A"))) {
        new_x -= 32;
        moved = true;
		event_user(0)
    }
    if (keyboard_check(ord("D"))) {
        new_x += 32;
        moved = true;
		event_user(0)
    }
    if (keyboard_check(ord("W"))) {
        new_y -= 32;
        moved = true;
		event_user(0)
    }
    if (keyboard_check(ord("S"))) {
        new_y += 32;
        moved = true;
		event_user(0)
    }

    // Verifica colisão ANTES de mover
    if (moved && place_free(new_x, new_y)) {
        target_x = new_x;
        target_y = new_y;
        moving = true;
    }
}
