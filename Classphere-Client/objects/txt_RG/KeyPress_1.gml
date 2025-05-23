if (focused) {

    // Captura último caractere digitado
    var ch = keyboard_lastchar;

    // Só aceita números (0–9)
    if (ord(ch) >= ord("0") && ord(ch) <= ord("9")) {
        text += ch;
    }
}
