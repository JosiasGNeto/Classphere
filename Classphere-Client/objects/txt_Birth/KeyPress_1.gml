if (focused) {
    // Remove tudo que não for número
    var only_numbers = "";
    for (var i = 1; i <= string_length(text); i++) {
        var ch = string_char_at(text, i);
        if (ord(ch) >= ord("0") && ord(ch) <= ord("9")) {
            only_numbers += ch;
        }
    }

    // Se tecla Backspace foi pressionada, apaga o último número
    if (keyboard_check_pressed(vk_backspace) && string_length(only_numbers) > 0) {
        only_numbers = string_copy(only_numbers, 1, string_length(only_numbers) - 1);
    }

    // Se um número foi pressionado
    var ch = keyboard_lastchar;
    if (ord(ch) >= ord("0") && ord(ch) <= ord("9") && string_length(only_numbers) < 8) {
        only_numbers += ch;
    }

    // Monta o texto formatado como DD-MM-AAAA
    var len = string_length(only_numbers);
    if (len <= 2) {
        text = only_numbers;
    } else if (len <= 4) {
        text = string_copy(only_numbers, 1, 2) + "-" + string_copy(only_numbers, 3, len - 2);
    } else {
        text = string_copy(only_numbers, 1, 2) + "-" + string_copy(only_numbers, 3, 2) + "-" + string_copy(only_numbers, 5, len - 4);
    }
}
