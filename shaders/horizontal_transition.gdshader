shader_type canvas_item;

uniform float startProgress = 0;
uniform float endProgress = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (UV.x < startProgress && UV.x > endProgress) {
		COLOR = vec4(0,0,0,1);
	} else {
		COLOR = vec4(0,0,0,0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
