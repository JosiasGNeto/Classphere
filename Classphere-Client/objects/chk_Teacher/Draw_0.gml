// Tamanho da checkbox
var box_size = 40;
var is_checked = (checked);

// Muda a cor da checkbox se estiver marcada
if (is_checked) {
    draw_set_color(c_lime); // cor verde quando marcado
} else {
    draw_set_color(c_white); // cor branca padrão
}

// Desenha o retângulo (a caixinha da checkbox)
draw_rectangle(x, y, x + box_size, y + box_size, false);

// Se marcada, desenha um X
if (is_checked) {
    draw_set_color(c_black); // X em preto
    draw_line(x, y, x + box_size, y + box_size);
    draw_line(x, y + box_size, x + box_size, y);
}

// Cor do texto
draw_set_color(c_black);
draw_text(x + box_size + 8, y, "Professor");

