// Verifica distância para player e teacher
var dist_player = 999999;
var dist_teacher = 999999;

if (instance_exists(obj_Player)) {
    dist_player = point_distance(x, y, obj_Player.x, obj_Player.y);
}
if (instance_exists(obj_Teacher)) {
    dist_teacher = point_distance(x, y, obj_Teacher.x, obj_Teacher.y);
}

// Posição do mouse no mundo (para clicar no obj_Info)
var mx = mouse_x;
var my = mouse_y;

if (!text_active &&
    (dist_player < 200 || dist_teacher < 200) &&
    mouse_check_button_pressed(mb_left) &&
    mx >= x - 8 && mx <= x + 8 &&
    my >= y - 8 && my <= y + 8) {
    text_active = true;
}

// Se o texto está ativo
if (text_active) {
    // Posição do botão de fechar (usando GUI)
    var btn_x = box_x + 146;
    var btn_y = box_y - 180;
    var btn_w = sprite_get_width(spr_Close);
    var btn_h = sprite_get_height(spr_Close);

    // Clique para fechar (na GUI)
    var gui_mx = device_mouse_x_to_gui(0);
    var gui_my = device_mouse_y_to_gui(0);

    if (gui_mx > btn_x && gui_mx < btn_x + btn_w &&
        gui_my > btn_y && gui_my < btn_y + btn_h &&
        mouse_check_button_pressed(mb_left)) {
        text_active = false;
    }

    // Fecha se se afastar demais
    if (dist_player > 300 && dist_teacher > 300) {
        text_active = false;
    }

    // Fecha com ESC
    if (keyboard_check_pressed(vk_escape)) {
        text_active = false;
    }
}
