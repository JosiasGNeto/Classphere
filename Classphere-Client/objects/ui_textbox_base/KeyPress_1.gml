if (focused) {
    if (keyboard_key == vk_backspace) {
        text = string_copy(text, 0, string_length(text) - 1);
    } else {
        var ch = keyboard_lastchar;
        var ch_ord = ord(ch);
        
        // Adiciona apenas se for um caractere imprimível (ASCII entre 32 e 126)
        if (ch_ord >= 32 && ch_ord <= 126) {
            text += ch;
        }
    }
}
