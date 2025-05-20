if (focused) {
    // Apagar com backspace
    if (keyboard_check_pressed(vk_backspace)) {
        if (string_length(text) > 0) {
            text = string_copy(text, 1, string_length(text) - 1);
        }
    }

    // Captura último caractere digitado
    var ch = keyboard_lastchar;

    // Só aceita números (0–9)
    if (ord(ch) >= ord("0") && ord(ch) <= ord("9")) {
        text += ch;
    }
}
