shader_type canvas_item;

uniform sampler2D gradientTexture;
//uniform vec2 blockSize = vec2(45, 15);
//uniform float borderWidth = 1.0; 

void fragment() {
	vec4 textColor = texture(gradientTexture, UV);
	// Border doen'st work
	
	//vec2 borderSize = 1.0 / blockSize * borderWidth;
	//
	//if (UV.x <= borderSize.x ||
	 //UV.x >= 1.0 - borderSize.x||
	 //UV.y <= borderSize.y ||
	 //UV.y >= 1.0 - borderSize.y) {
		//COLOR = COLOR;
	//} else {
	COLOR = max(COLOR, textColor);

}