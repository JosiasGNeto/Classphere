// Área de ativação (ajustável)
var padding = 16;
var x1 = bbox_left - padding;
var y1 = bbox_top - padding;
var x2 = bbox_right + padding;
var y2 = bbox_bottom + padding;

var player_near = collision_rectangle(x1, y1, x2, y2, obj_Player, false, true);
var teacher_near = collision_rectangle(x1, y1, x2, y2, obj_Teacher, false, true);

// Mostrar ícone "Press E"
show_press_e = ((player_near || teacher_near) && (state == "closed" || state == "open"));

// Apertou E perto da porta
if ((player_near || teacher_near) && keyboard_check_pressed(ord("E"))) {

    // Abrir
    if (state == "closed") {
        sprite_index = spr_Bathroom_Sink_Open;
        image_index = 0;
        image_speed = 1;
        state = "opening";

    }

    // Fechar
    else if (state == "open") {
        sprite_index = spr_Bathroom_Sink_Close;
        image_index = 0;
        image_speed = 1;
        state = "closing";
    }
}
