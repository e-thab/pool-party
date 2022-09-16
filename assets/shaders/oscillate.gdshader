shader_type canvas_item;

uniform float speed = 3.0;
uniform float height = 2.0;

void vertex(){
	float x = TIME*speed;
	VERTEX += vec2(0.0, sin(x) * height);
//	VERTEX += vec2(0.0, -pow(sin(x), 2) * height);  //-sin^2(x) * height
}