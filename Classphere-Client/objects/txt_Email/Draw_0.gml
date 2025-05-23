draw_self();

// Se estiver com foco, desenha retângulo com borda
if (focused) {
    var w = 384;
    var h = 42;
    var border_thickness = 5;
    
    // Escolha a cor da borda aqui:
    var border_color = make_color_rgb(124, 61, 225);

    // Retângulo maior (borda)
    draw_set_color(border_color);
    draw_roundrect_ext(x - 390 - border_thickness, y - 48 - border_thickness,
                       x + w + border_thickness, y + h + border_thickness,
                       42, 42, false);

    // Retângulo menor (fundo real)
    draw_set_color(c_white); // Cor de fundo
    draw_roundrect_ext(x - 390, y - 49, x + w, y + h, 40, 40, false);
    
    draw_set_color(c_white); // Reset
}

// Texto
if (string_length(text) > 0 || focused) {
    draw_set_color(make_color_rgb(92, 40, 176));
    draw_text(x - 350 , y - 22, string(text));
	if (focused && cursor_visible) {
	    var text_width = string_width(text);
	    var cursor_x = x - 350 + text_width + 2; // +2 para dar um pequeno espaço do texto
	    var cursor_y1 = y - 22;
	    var cursor_y2 = cursor_y1 + string_height("A") - 4;

	    draw_set_color(make_color_rgb(92, 40, 176)); // mesma cor do texto
	    draw_line(cursor_x, cursor_y1, cursor_x, cursor_y2);
	}
} else {
	draw_set_color(make_color_rgb(174, 136, 236));
    draw_text(x - 350 , y - 22, string(placeholder));
}
