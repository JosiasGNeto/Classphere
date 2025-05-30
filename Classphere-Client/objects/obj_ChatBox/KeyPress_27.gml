if (chat_active) {
    chat_active = false; 
	global.chat_active = false;
    chat_input = "";     
}

if (chat_expanded) {
    chat_expanded = false;
    chat_active = false;
    global.chat_active = false;
}