shader_type canvas_item;

uniform sampler2D hidden_texture;
uniform vec2 position = vec2(0, 0);
uniform float zoom = 1.0;
uniform float size = 10.0;

void fragment() {
	vec4 main_color = texture(TEXTURE, UV);
	
	if (main_color.a != 0.0) {
		vec2 fraam = fract(vec2(UV.x*zoom, UV.y*zoom));
		COLOR.rgba = texture(hidden_texture, fraam).rgba;
	} 
}