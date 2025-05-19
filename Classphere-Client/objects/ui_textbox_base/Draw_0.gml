draw_self();

// Se estiver com foco, desenha retângulo com cor específica
if (focused) {
    draw_set_color(make_color_rgb(128, 0, 128)); // cor que você quiser para o foco
    draw_rectangle(x, y, x + (16 * image_xscale), y + (16 * image_yscale), false);
    draw_set_color(c_white); // volta a cor pro padrão para não afetar outros desenhos
}

// Texto
if (string_length(text) > 0 || focused) {
	draw_set_color(make_color_rgb(174, 136, 236));
    draw_text(x + 3, y + 8, string(text));
} else {
    draw_text(x + 3, y + 8, string(placeholder));
}
