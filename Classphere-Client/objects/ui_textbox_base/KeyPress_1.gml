if (focused) {

	var ch = keyboard_lastchar;
	var ch_ord = ord(ch);
        
	// Adiciona apenas se for um caractere imprimível (ASCII entre 32 e 126)
	if (ch_ord >= 32 && ch_ord <= 126) {
	    text += ch;
	}

}
