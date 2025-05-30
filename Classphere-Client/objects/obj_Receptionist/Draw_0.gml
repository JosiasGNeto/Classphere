draw_self();
draw_text(x - (string_width(name) / 2), y - 42, name);

if (show_text) {
    draw_sprite(text_sprite, 0, x + 100, y - 50);
}
