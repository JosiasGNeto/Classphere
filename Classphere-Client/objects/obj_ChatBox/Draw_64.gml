// Primeiro, captura posição do mouse na GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// 1. Desenha o botão do chat (ícone), se não estiver expandido
if (!chat_expanded) {
    if (has_new_message) {
        draw_sprite(spr_ChatBox_NewMsg, 0, chat_icon_x, chat_icon_y); // Sprite com notificação
    } else {
        draw_sprite(spr_ChatBox, 0, chat_icon_x, chat_icon_y);        // Sprite normal
    }

    // Verifica se mouse está sobre o botão do chat (supondo que o sprite tenha 32x32)
    var icon_size = 32;
    if (point_in_rectangle(mx, my, chat_icon_x - icon_size/2, chat_icon_y - icon_size/2, chat_icon_x + icon_size/2, chat_icon_y + icon_size/2)) {
        cursor_sprite = spr_cursor2;
    } else {
        cursor_sprite = spr_cursor1;
    }
}

// 2. Desenha o chat e botão "X" se expandido
if (chat_expanded) {
    // Variáveis para o chat
    var margem_inferior = 60;
    var altura_chat = 200;
    var largura_chat = 505;
    var x_inicial = 15;

    var janela_altura = 720;
    var y_base = janela_altura - margem_inferior;
    var y_topo = y_base - altura_chat;

    // Desenha caixa do chat e mensagens (igual antes)
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(x_inicial, y_topo, x_inicial + largura_chat, y_base, false);
    draw_set_color(c_white);
    draw_rectangle(x_inicial, y_topo, x_inicial + largura_chat, y_base, true);
    draw_set_alpha(1);

    draw_set_font(fnt_Chat);
    draw_set_color(c_white);
    var a = y_base - 20;
    for (var i = array_length(chat_log) - 1; i >= 0 && i >= array_length(chat_log) - max_messages; i--) {
        draw_text(x_inicial + 15, a, chat_log[i]);
        a -= 30;
    }
    if (chat_active) {
        var input_topo = y_base + 10;
        var input_base = input_topo + 30;
        draw_set_color(c_black);
        draw_rectangle(x_inicial, input_topo, x_inicial + largura_chat, input_base, false);
        draw_set_color(c_white);
        draw_text(x_inicial + 15, input_topo + 5, chat_input + "|");
    }
    draw_set_font(-1);

    // Botão "X"
    var close_size = 32;
    var close_x = x_inicial + largura_chat - close_size - 10;
    var close_y = y_topo + 10;
    draw_sprite(spr_ChatClose, 0, close_x + close_size / 2, close_y + close_size / 2);

    // Verifica se mouse está sobre o botão "X"
    if (point_in_rectangle(mx, my, close_x, close_y, close_x + close_size, close_y + close_size)) {
        cursor_sprite = spr_cursor2;
    } else {
        cursor_sprite = spr_cursor1;
    }
}
