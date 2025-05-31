// Área de ativação (ajustável)
var padding = 8;
var x1 = bbox_left - padding;
var y1 = bbox_top - padding;
var x2 = bbox_right + padding;
var y2 = bbox_bottom + padding;

var player_near = collision_rectangle(x1, y1, x2, y2, obj_Player, false, true);
var teacher_near = collision_rectangle(x1, y1, x2, y2, obj_Teacher, false, true);

// Mostrar ícone "Press E"
show_press_e = ((player_near || teacher_near) && (door_state == "closed" || door_state == "open"));

// Apertou E perto da porta
if ((player_near || teacher_near) && keyboard_check_pressed(ord("E"))) {

    // Abrir
    if (door_state == "closed") {
        sprite_index = spr_Door_Open;
        image_index = 0;
        image_speed = 1;
        door_state = "opening";

        // Envia para o servidor
        var buffer = buffer_create(256, buffer_grow, 1);
        buffer_write(buffer, buffer_string, "DOOR");
        buffer_write(buffer, buffer_string, string(id));
        buffer_write(buffer, buffer_string, "OPEN");
        network_write(Network.socket, buffer);
        buffer_delete(buffer);
    }

    // Fechar
    else if (door_state == "open") {
        var inside_player = place_meeting(x, y, obj_Player);
        var inside_teacher = place_meeting(x, y, obj_Teacher);

        if (!inside_player && !inside_teacher) {
            sprite_index = spr_Door_Close;
            image_index = 0;
            image_speed = 1;
            door_state = "closing";

            solid = true;

            // Envia para o servidor
            var buffer = buffer_create(256, buffer_grow, 1);
            buffer_write(buffer, buffer_string, "DOOR");
            buffer_write(buffer, buffer_string, string(id));
            buffer_write(buffer, buffer_string, "CLOSE");
            network_write(Network.socket, buffer);
            buffer_delete(buffer);
        }
    }
}
