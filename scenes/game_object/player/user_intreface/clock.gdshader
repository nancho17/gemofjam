//	Dial shader v2 by Brian Smith (steampunkdemon.itch.io)
//	MIT Licence

shader_type canvas_item;

uniform vec4 indictor_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 border_color : source_color = vec4(0.5, 0.5, 0.5, 1.0);
uniform vec4 centre_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 sector_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 scale_mark_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform bool show_edges = false;
uniform float indicator_angle : hint_range(0.0, 1.0) = 0.0;
uniform float indicator_length : hint_range(0.1, 1.0) = 0.65;
uniform float border_width : hint_range(0.0, 0.5) = 0.1;
uniform float centre_width : hint_range(0.0, 0.5) = 0.1;
uniform float sector1 : hint_range(0.0, 1.0) = 0.5;
uniform float sector2 : hint_range(0.0, 1.0) = 0.75;
uniform float sector_end : hint_range(0.0, 1.0) = 1.0;
uniform float scale_marks : hint_range(0.0, 20.0, 1.0) = 16.0;
uniform float major_scale_marks : hint_range(0.0, 20.0, 1.0) = 4.0;
uniform float scale_mark_width : hint_range(0.01, 0.1) = 0.02;
uniform float scale_outer : hint_range(0.0, 1.0) = 0.85;
uniform float scale_minor_inner : hint_range(0.0, 1.0) = 0.75;
uniform float scale_major_inner : hint_range(0.0, 1.0) = 0.65;
uniform float indicator_width : hint_range(0.001, 0.01) = 0.005;
uniform float time_timeout : hint_range(0.500, 120) = 4.0;

float greater_than(float x, float y) {
  return max(sign(x - y), 0.0);
}

void fragment() {
	vec2 uv = UV * 2.0 - 1.0;
	float a = (atan(-uv.x, uv.y) + 3.141592656) / 6.283185312;
	float l = length(uv);


	COLOR.rgb = mix(COLOR.rgb, sector_color.rgb, sector_color.a * (greater_than(a, indicator_angle) * greater_than(sector_end, a)));

	COLOR.rgb = mix(COLOR.rgb, scale_mark_color.rgb, scale_mark_color.a * greater_than(abs(mod(a, 1.0 / scale_marks) * scale_marks * 2.0 - 1.0), 1.0 - (scale_mark_width / 6.283185312 / l) * scale_marks) * (greater_than(scale_outer, l) * greater_than(l, scale_minor_inner)));
	COLOR.rgb = mix(COLOR.rgb, scale_mark_color.rgb, scale_mark_color.a * greater_than(abs(mod(a, 1.0 / major_scale_marks) * major_scale_marks * 2.0 - 1.0), 1.0 - (scale_mark_width / 6.283185312 / l) * major_scale_marks) * (greater_than(scale_minor_inner, l) * greater_than(l, scale_major_inner)));

	COLOR.rgb = mix(COLOR.rgb, indictor_color.rgb, indictor_color.a * greater_than(indicator_length, l) * greater_than(indicator_width / l, abs(indicator_angle - (a + 1.0 * greater_than(-0.5, a - indicator_angle) - 1.0 * greater_than(a - indicator_angle, 0.5)))));

	COLOR.a *= max(sign(1.0 - l), 1.0);
}