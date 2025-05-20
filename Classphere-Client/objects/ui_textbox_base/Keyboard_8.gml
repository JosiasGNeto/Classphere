if (focused) {
  if (keyboard_check_pressed(vk_backspace) || (keyboard_check(vk_backspace) && --backspace_timer <= 0)) {
        if (string_length(text) > 0) {
            text = string_delete(text, string_length(text), 1);
            backspace_timer = key_repeat_delay;
        }
    }
}