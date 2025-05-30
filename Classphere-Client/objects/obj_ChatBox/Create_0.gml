// Inicialização do chat
chat_log = [];             // Armazena as mensagens do chat
chat_input = "";           // Texto que o jogador está digitando
chat_active = false;       // Campo de digitação está ativo?
global.chat_active = false;
max_messages = 6;          // Número de mensagens visíveis no histórico

chat_expanded = false; // Chat está expandido ou recolhido?
chat_icon_x = 52;      // Posição X do botão (ícone)
chat_icon_y = 672;     // Posição Y do botão
chat_icon_size = 48;   // Tamanho do botão

x_inicial = 15;
largura_chat = 505;
altura_chat = 200;
margem_inferior = 60;
janela_altura = 720;

has_new_message = false;

// Função para adicionar mensagem ao chat
function add_chat_message(msg) {
    array_push(chat_log, msg);
    if (!chat_expanded) {
        has_new_message = true; 
    }
}
