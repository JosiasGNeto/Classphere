if(hover){
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, make_color_rgb(186, 146, 251), 1.0);
}
else{
	draw_self()
}

draw_text(x + 3, y + 8, string(text));