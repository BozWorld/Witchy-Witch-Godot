shader_type canvas_item;

global uniform vec2 cam_offset = vec2(0.0 , 0.0);

void vertex() {
	VERTEX += cam_offset;
}