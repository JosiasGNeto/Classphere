if (sprite_index == spr_Door_Open) {
    // Terminou de abrir
    sprite_index = spr_Door_Opened; // sprite estático (opcional)
    image_speed = 0;
    door_state = "open";
    solid = false; // ✅ só agora libera a passagem
}
else if (sprite_index == spr_Door_Close) {
    // Terminou de fechar
    sprite_index = spr_Door_Closed;
    image_speed = 0;
    door_state = "closed";
}
