// Tamanho da checkbox
var box_size = 40;
var is_checked = (checked);

// Desenhar quadrado da checkbox
draw_rectangle(x, y, x + box_size, y + box_size, false);

// Se estiver marcada, desenha um X ou preenchimento
if (is_checked) {
    draw_line(x, y, x + box_size, y + box_size);
    draw_line(x, y + box_size, x + box_size, y);
}

// Texto ao lado
draw_text(x + box_size + 8, y, "Sou professor");
