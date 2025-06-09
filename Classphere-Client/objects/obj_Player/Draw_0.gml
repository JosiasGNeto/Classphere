draw_self();

draw_set_font(fnt_Small);

// Desenha o contorno branco
draw_set_color(c_white);
var xx = x - (string_width(name) / 2);
var yy = y - 35;

// Desenha o texto em 8 direções ao redor (contorno)
draw_text(xx - 1, yy - 1, name);
draw_text(xx + 1, yy - 1, name);
draw_text(xx - 1, yy + 1, name);
draw_text(xx + 1, yy + 1, name);
draw_text(xx - 1, yy, name);
draw_text(xx + 1, yy, name);
draw_text(xx, yy - 1, name);
draw_text(xx, yy + 1, name);

// Desenha o texto principal por cima (preto)
draw_set_color(c_black);
draw_text(xx, yy, name);

