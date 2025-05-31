draw_self();

// Se o player estiver perto, mostra o ícone de "Pressione E"
if (show_press_e) {
    draw_sprite(spr_PressE, 0, x - 50, y - sprite_height + 20);
}