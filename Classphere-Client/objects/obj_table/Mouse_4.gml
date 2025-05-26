if (!is_player_sitting && instance_exists(obj_Player)) {
    if (point_distance(x, y, obj_Player.x, obj_Player.y) < interaction_range) {
        is_player_sitting = true;
        
        with (obj_Player) {
            visible = false;
            active = false;
            moving = false;
            sit_original_x = x;
            sit_original_y = y;
        }
        
        sitting_sprite = instance_create_layer(x, y, layer, obj_Player_Sitting);
        sitting_sprite.depth = depth - 1;
        sitting_sprite.x = x + sprite_xoff;
        sitting_sprite.y = y + sprite_yoff;
    }
}