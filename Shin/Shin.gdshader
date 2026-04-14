shader_type canvas_item;

// Màu cần xóa (chọn trong Inspector)
uniform vec4 color_to_remove : source_color = vec4(1.0, 1.0, 1.0, 1.0);
// Độ nhạy để xóa sạch viền
uniform float sensitivity : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    vec4 curr_color = texture(TEXTURE, UV);
    // Tính khoảng cách màu giữa pixel hiện tại và màu nền
    float dist = distance(curr_color.rgb, color_to_remove.rgb);
    
    if (dist < sensitivity) {
        curr_color.a = 0.0; // Làm trong suốt pixel đó
    }
    COLOR = curr_color;
}