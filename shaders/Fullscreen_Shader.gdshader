shader_type canvas_item;
uniform vec4 Set_color: source_color;
uniform float Opacity = 0;

// --- Uniforms --- //
uniform vec2 speed = vec2(0.0, 0.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec4 color = texture(TEXTURE, UV);
	color = mix(color, Set_color, Opacity * color.a);

	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
