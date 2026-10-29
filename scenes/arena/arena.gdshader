shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

const float TWO_PI = 6.28318530718;

vec4 polygon(vec2 uv, float width, int sides)
{
	uv = uv * 2.0 - 1.0;

	float angle = atan(uv.x, uv.y);
	float radius = TWO_PI / float(sides);
	
	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);
	float poly = step(width, dist);
	return vec4(vec3(poly), 1.0);
}


void fragment() {
	polygon(UV, 10, 3);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
