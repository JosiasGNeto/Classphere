if (instance_position(mouse_x, mouse_y, ui_button_base) || instance_position(mouse_x, mouse_y, ui_textbox_base)) {
    cursor_sprite = spr_cursor2;
} else {
    cursor_sprite = spr_cursor1;
}