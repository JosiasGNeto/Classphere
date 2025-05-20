// Definir fonte e cor dependendo do hover
if (hover) {
    // Desenhar o botão com cor personalizada
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(124, 61, 225), 1.0);
    
    draw_set_font(fnt_default);
    draw_set_color(c_white);  // Cor do texto ao passar o mouse
    draw_text(x - 80 , y - 24, string(text));
} else {
    // Desenhar o botão normalmente
    draw_self();
    
    draw_set_font(fnt_default);
    draw_set_color(make_color_rgb(92, 40, 176));    // Cor normal do texto
    draw_text(x - 80 , y - 24, string(text));
}