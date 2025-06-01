if (sprite_index == spr_Fridge_Cake_Open) {
    // Terminou de abrir
    sprite_index = spr_Fridge_Cake_Opened; // sprite estático (opcional)
    image_speed = 0;
    door_state = "open";
}
else if (sprite_index == spr_Fridge_Cake_Close) {
    // Terminou de fechar
    sprite_index = spr_Fridge_Cake_Closed;
    image_speed = 0;
    door_state = "closed";
}
