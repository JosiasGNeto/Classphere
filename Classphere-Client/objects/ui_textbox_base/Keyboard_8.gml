    if (keyboard_check_pressed(vk_backspace)) {
        // Apaga instantaneamente ao pressionar
        text = string_copy(text, 0, string_length(text) - 1);
        backspace_timer = key_repeat_delay;
        backspace_held = true;
    }
    else if (keyboard_check(vk_backspace) && backspace_held) {
        // Após atraso, continua apagando enquanto segurar
        backspace_timer--;
        if (backspace_timer <= 0) {
            text = string_copy(text, 0, string_length(text) - 1);
            backspace_timer = key_repeat_speed; // velocidade contínua
        }
    }
    else {
        backspace_held = false;
    }