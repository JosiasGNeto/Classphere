// Step Event do obj_Player

// Se o player estiver inativo, sai
if (!active) exit;

// Se estiver sentado, mantém sprite sentado
if (is_sitting) {
    sprite_index = sprite_sitting;

    // Bloqueia movimento se chat estiver ativo
    if (global.chat_active) {
        // Se o chat estiver aberto, não processa movimento nem troca sprite
        exit;
    }

} else {

    // Se estiver aberto o chat, bloqueia movimento e não altera sprite
    if (global.chat_active) {
        // Se o chat está ativo e o player não está sentado,
        // mantém o sprite idle baseado na última direção, mas não se move
        switch (last_direction) {
            case "left":
                sprite_index = spr_Student_Iddle_Left;
                break;
            case "right":
                sprite_index = spr_Student_Iddle_Right;
                break;
            case "up":
                sprite_index = spr_Student_Iddle_Up;
                break;
            case "down":
                sprite_index = spr_Student_Iddle_Down;
                break;
        }
        image_speed = 1;
        exit;
    }

    // Se está se movendo
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

    // Entrada de teclado só quando não está se movendo
    if (!moving) {
        var moved = false;
        var new_x = target_x;
        var new_y = target_y;

        if (keyboard_check(ord("A"))) {
            new_x -= 8;
            moved = true;
            last_direction = "left";
            sprite_index = spr_Student_Walking_Left;
            image_speed = 1;
            event_user(0);
        }
        else if (keyboard_check(ord("D"))) {
            new_x += 8;
            moved = true;
            last_direction = "right";
            sprite_index = spr_Student_Walking_Right;
            image_speed = 1;
            event_user(0);
        }
        else if (keyboard_check(ord("W"))) {
            new_y -= 8;
            moved = true;
            last_direction = "up";
            sprite_index = spr_Student_Walking_Up;
            image_speed = 1;
            event_user(0);
        }
        else if (keyboard_check(ord("S"))) {
            new_y += 8;
            moved = true;
            last_direction = "down";
            sprite_index = spr_Student_Walking_Down;
            image_speed = 1;
            event_user(0);
        }

        if (moved && place_free(new_x, new_y)) {
            target_x = new_x;
            target_y = new_y;
            moving = true;
        } else if (!moved) {
            // Se não moveu, sprite idle baseado na última direção
            switch (last_direction) {
                case "left":
                    sprite_index = spr_Student_Iddle_Left;
                    break;
                case "right":
                    sprite_index = spr_Student_Iddle_Right;
                    break;
                case "up":
                    sprite_index = spr_Student_Iddle_Up;
                    break;
                case "down":
                    sprite_index = spr_Student_Iddle_Down;
                    break;
            }
            image_speed = 1;
        }
    }
}
