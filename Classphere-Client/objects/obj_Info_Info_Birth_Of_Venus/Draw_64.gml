if (text_active) {
    draw_set_alpha(0.7);
    draw_sprite(spr_Info_Birth_Of_Venus, 0, box_x, box_y);
    draw_set_alpha(1);

    var btn_x = box_x + padding_x;
    var btn_y = box_y - padding_y;
    draw_sprite(spr_Close, 0, btn_x, btn_y);
}
