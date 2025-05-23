draw_self();

var border_thickness = 5;
var border_color = make_color_rgb(124, 61, 225);
var is_register = (room == register);

var x_offset = is_register ? 190 : 390;
var w = is_register ? 192 : 384;
var h = 44;

// Retângulo maior (borda)
if (focused) {
    draw_set_color(border_color);
    draw_roundrect_ext(x - x_offset - border_thickness, y - 48 - border_thickness,
                       x + w + border_thickness, y + h + border_thickness,
                       42, 42, false);
}

// Retângulo menor (fundo real)
draw_set_color(c_white);
draw_roundrect_ext(x - x_offset, y - 49, x + w, y + h, 35, 35, false);

// Texto ou Placeholder
var text_x = is_register ? x - 160 : x - 350;
var draw_color = make_color_rgb(92, 40, 176);
var placeholder_color = make_color_rgb(174, 136, 236);

if (string_length(text) > 0) {
    draw_set_color(draw_color);
    draw_text(text_x, y - 22, string(text));
	if (focused && cursor_visible) {
	    var text_width = string_width(text);
	    var cursor_x = x - 350 + text_width + 2; // +2 para dar um pequeno espaço do texto
	    var cursor_y1 = y - 22;
	    var cursor_y2 = cursor_y1 + string_height("A") - 4;

	    draw_set_color(make_color_rgb(92, 40, 176)); // mesma cor do texto
	    draw_line(cursor_x, cursor_y1, cursor_x, cursor_y2);
	}
	
} else {
    draw_set_color(placeholder_color);
    draw_text(text_x, y - 22, string(placeholder));
}

// Reset cor
draw_set_color(c_white);
