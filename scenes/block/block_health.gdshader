shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void vertex() {
}

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	COLOR = vec4(1.0 - color.rgb, color.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
