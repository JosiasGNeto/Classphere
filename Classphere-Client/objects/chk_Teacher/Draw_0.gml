// Tamanho do círculo
var radius = 25;

// Se estiver marcado, cor verde; senão, branco
if (checked) {
    draw_set_color(make_color_rgb(92, 40, 176));
} else {
    draw_set_color(c_white);
}

// Desenha o círculo (outline)
draw_circle(x + radius, y + radius, radius, false);

// Se estiver marcado, preenche o círculo com a mesma cor
if (checked) {
    draw_circle(x + radius, y + radius, radius - 4, true); // círculo interno preenchido (um pouco menor para borda)
}

// Cor do texto
draw_set_color(c_white);
draw_text(x + radius * 2 + 16, y + radius - string_height("Professor")/2, "Professor");
