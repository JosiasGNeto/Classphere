if (sprite_index == spr_Bathroom_Sink_Open) {
    // Terminou de abrir
    sprite_index = spr_Bathroom_Sink_Open; // sprite estático (opcional)
    image_speed = 1;
    state = "open";
}
else if (sprite_index == spr_Bathroom_Sink_Close) {
    // Terminou de fechar
    sprite_index = spr_Bathroom_Sink_Closed;
    image_speed = 0;
    state = "closed";
}
