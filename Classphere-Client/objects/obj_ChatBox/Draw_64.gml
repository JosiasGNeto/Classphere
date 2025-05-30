// Configurações para controlar posição e tamanho do chat
var margem_inferior = 60;    // distância da parte inferior da janela até a base do chat
var altura_chat = 200;       // altura total da área do chat
var largura_chat = 505;      // largura do chat
var x_inicial = 15;          // posição x inicial do chat

// Calcula Y topo e Y base do chat baseado na janela
var janela_altura = 720;
var y_base = janela_altura - margem_inferior;         // base do retângulo
var y_topo = y_base - altura_chat;                    // topo do retângulo

// Caixa do chat
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(x_inicial, y_topo, x_inicial + largura_chat, y_base, false);
draw_set_color(c_white);
draw_rectangle(x_inicial, y_topo, x_inicial + largura_chat, y_base, true);
draw_set_alpha(1);

// Mensagens do chat
draw_set_font(fnt_Chat);
draw_set_color(c_white);

var a = y_base - 20; // Posição inicial para desenhar mensagens
for (var i = array_length(chat_log) - 1; i >= 0 && i >= array_length(chat_log) - max_messages; i--) {
    draw_text(x_inicial + 15, a, chat_log[i]);
    a -= 30; // espaçamento entre mensagens
}

// Campo de digitação
if (chat_active) {
    var input_topo = y_base + 10;   
    var input_base = input_topo + 30;

    draw_set_color(c_black);
    draw_rectangle(x_inicial, input_topo, x_inicial + largura_chat, input_base, false);
    draw_set_color(c_white);
    draw_text(x_inicial + 15, input_topo + 5, chat_input + "|");
}

draw_set_font(-1);
