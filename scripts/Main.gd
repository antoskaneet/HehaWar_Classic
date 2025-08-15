extends Node2D

@export var hex_scene: PackedScene

func _ready():
	for i in range(5):
		var hex = hex_scene.instantiate()
		hex.position = Vector2(100, i * 80)
		hex.data.color = "#ff0000"
		UnitColorManager.set_color(hex)
		add_child(hex)
	
	for i in range(5):
		var hex = hex_scene.instantiate()
		hex.position = Vector2(400, i * 80)
		hex.data.color = "#0000ff"
		UnitColorManager.set_color(hex)
		add_child(hex)
