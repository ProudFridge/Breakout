shader_type canvas_item;

uniform sampler2D noise_texture;
uniform vec2 speed = vec2(1.0, 0.4);

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = clamp(texture(noise_texture, mod(UV + TIME * speed, 1.0)) * COLOR, vec4(0.2,0.2,0.2,0.2) * COLOR,vec4(1,1,1,1));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
