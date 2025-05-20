if (focused) {
    var ch = keyboard_lastchar;
    var ch_ord = ord(ch);
        
    if (ch_ord >= 32 && ch_ord <= 126 && ch != last_char) {
        text += ch;
        last_char = ch;
    }
}