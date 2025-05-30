if (chat_active) {
    if (keyboard_check_pressed(vk_backspace)) {
        chat_input = string_delete(chat_input, string_length(chat_input), 1);
    } else {
        var key = keyboard_lastchar;
        if (string_length(key) > 0 && ord(key) >= 32) {
            chat_input += key;
        }
    }
}
