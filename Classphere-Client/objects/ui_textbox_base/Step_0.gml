if (focused) {
    cursor_timer++;
    if (cursor_timer >= cursor_blink_rate) {
        cursor_timer = 0;
        cursor_visible = !cursor_visible;
    }
} else {
    cursor_visible = false;
    cursor_timer = 0;
}
