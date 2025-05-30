// Caixa do chat
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(20, 400, 620, 600, false);
draw_set_alpha(1);

// Mostrar mensagens (de baixo pra cima)
draw_set_color(c_white);
var a = 580;
for (var i = array_length(chat_log) - 1; i >= 0 && i >= array_length(chat_log) - max_messages; i--) {
    draw_text(30, y, chat_log[i]);
   a -= 20;
}

// Campo de digitação
if (chat_active) {
    draw_rectangle(20, 610, 620, 640, false);
    draw_text(30, 615, chat_input + "|");
}
