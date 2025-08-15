extends Node

var material_cache := {} 

func set_color(_unit: Node):
	var sprite = _unit.get_node("Sprite2D")
	var color_str = _unit.data.color

	if not material_cache.has(color_str):
		var mat = sprite.material.duplicate() as ShaderMaterial
		mat.set_shader_parameter("team_color", Color.html(color_str))
		material_cache[color_str] = mat
	
	sprite.material = material_cache[color_str]
