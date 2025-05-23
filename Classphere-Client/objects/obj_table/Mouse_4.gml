// obj_table Mouse Left Pressed Event
if (!is_player_sitting) {
    // Verifica se o player está perto o suficiente
    if (instance_exists(obj_Player) && 
        point_distance(x, y, obj_Player.x, obj_Player.y) < interaction_range) {
        
        // Marca que o player está sentado
        is_player_sitting = true;
        player_sitting = obj_Player;
        
        // Desativa o player normal
        obj_Player.visible = false;
        obj_Player.moving = false; // Adicione esta variável no player
        
        // Cria o sprite do player sentado
        sitting_sprite = instance_create_layer(x, y, layer, obj_Player_Sitting);
        sitting_sprite.depth = depth - 1; // Ajusta a profundidade se necessário
        
        // Posiciona corretamente o sprite sentado
        sitting_sprite.x = x + sprite_xoff; // Ajuste conforme necessário
        sitting_sprite.y = y + sprite_yoff; // Ajuste conforme necessário
    }
}