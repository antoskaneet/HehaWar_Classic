shader_type canvas_item;

uniform vec4 team_color;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = vec4(team_color.rgb, tex_color.a);
}
