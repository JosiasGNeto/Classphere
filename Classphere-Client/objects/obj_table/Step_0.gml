if (is_player_sitting && keyboard_check_pressed(vk_space)) {
    is_player_sitting = false;
    
    with (obj_Player) {
        visible = true;
        active = true;
        moving = false;
        x = sit_original_x;
        y = sit_original_y;
        target_x = x;
        target_y = y;
    }
    
    if (instance_exists(sitting_sprite)) {
        instance_destroy(sitting_sprite);
    }
}