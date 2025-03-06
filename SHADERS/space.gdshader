shader_type sky;

uniform vec3 skyColor : source_color;
uniform sampler2D spaceTex;

void sky() {
	COLOR = texture(spaceTex,SKY_COORDS).rgb;
}
