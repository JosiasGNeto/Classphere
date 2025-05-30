// Captura posições do mouse na GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Clique no botão do chat (ícone) para abrir/fechar
if (mouse_check_button_pressed(mb_left)) {
    // Área do botão do chat - considerando que o sprite está centralizado na posição
    var half_icon = chat_icon_size / 2;
    if (point_in_rectangle(mx, my, chat_icon_x - half_icon, chat_icon_y - half_icon, chat_icon_x + half_icon, chat_icon_y + half_icon)) {
        chat_expanded = !chat_expanded;
        global.chat_active = false;
        chat_active = false;
        
        if (chat_expanded) {
            has_new_message = false;  // Limpa notificação ao abrir o chat
        }
    }
}

// Clique no botão "X" para fechar, se chat estiver expandido
if (chat_expanded && mouse_check_button_pressed(mb_left)) {
    var y_base = janela_altura - margem_inferior;
    var y_topo = y_base - altura_chat;
    
    var close_size = 32;
    var close_x = x_inicial + largura_chat - close_size - 10;
    var close_y = y_topo + 10;
    
    if (point_in_rectangle(mx, my, close_x, close_y, close_x + close_size, close_y + close_size)) {
        chat_expanded = false;
        chat_active = false;
        global.chat_active = false;
        chat_input = "";
    }
}
