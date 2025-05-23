// obj_table Step Event
if (is_player_sitting && keyboard_check_pressed(vk_space)) {
    is_player_sitting = false;
    
    // Reativa o player normal
    player_sitting.visible = true;
    player_sitting.moving = true;
    
    // Remove o sprite sentado
    if (instance_exists(sitting_sprite)) {
        instance_destroy(sitting_sprite);
    }
    
    player_sitting = noone;
}