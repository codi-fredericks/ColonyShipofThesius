shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 0.0;
uniform sampler2D screen : hint_screen_texture;

void fragment(){
	vec4 color = texture(screen, SCREEN_UV, lod);
	COLOR = color;
}