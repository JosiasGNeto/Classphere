if (focused) {
    var ch = keyboard_lastchar;
    var ch_ord = ord(ch);
        
    if (ch_ord >= 32 && ch_ord <= 126 && ch != last_char) {
        text += ch;
        last_char = ch;
    }
	
	// Tecla Tab pressionada
	if (keyboard_check_pressed(vk_tab)) {
		focused = false;
        
		// Transfere o foco para o próximo campo (se existir)
		if (instance_exists(tab_next)) {
		    tab_next.focused = true;
		}
	}
}
