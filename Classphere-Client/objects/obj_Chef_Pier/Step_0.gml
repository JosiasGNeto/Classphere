// Lógica de exibir texto temporário
if (show_text) {
    text_timer -= 1;
    if (text_timer <= 0) {
        show_text = false;
    }
}

// Contador para fala automática
speech_timer -= 1;
if (speech_timer <= 0) {
    var index = irandom(array_length(speech_sprites) - 1);
    text_sprite = speech_sprites[index];

    // Mostra o texto
    show_text = true;
    text_timer = text_duration;

    // Reinicia o timer
    speech_timer = speech_interval;
}