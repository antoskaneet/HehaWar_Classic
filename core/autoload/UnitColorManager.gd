extends Node

var material_cache := {} 

func set_color(_unit: Node, color_override: String = ""):
	var sprite = _unit.get_node("Sprite2D")
	var color_str = color_override if color_override != "" else _unit.data.color

	if not material_cache.has(color_str):
		var mat = sprite.material.duplicate() as ShaderMaterial
		mat.set_shader_parameter("team_color", Color.html(color_str))
		material_cache[color_str] = mat
	
	sprite.material = material_cache[color_str]

func darken_color(hex_color: String, darken_factor: float = 0.7) -> String:
	# Проверяем, что строка начинается с # и имеет длину 7
	if not hex_color.begins_with("#") or len(hex_color) != 7:
		return hex_color  # Возвращаем исходный цвет при неверном формате
	
	# Извлекаем RGB компоненты
	var r = hex_color.substr(1, 2).hex_to_int()
	var g = hex_color.substr(3, 2).hex_to_int()
	var b = hex_color.substr(5, 2).hex_to_int()
	
	# Затемняем каждую компоненту
	r = int(clamp(r * darken_factor, 0, 255))
	g = int(clamp(g * darken_factor, 0, 255))
	b = int(clamp(b * darken_factor, 0, 255))

	# Формируем новую HEX-строку
	var new_hex = "#%02x%02x%02x" % [r, g, b]
	return new_hex
