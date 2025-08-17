extends Node2D

@export var hex_scene: PackedScene

func _ready():
	
	var spacing = 120
	var count = 5
	
	# Верхний ряд (зелёные) — горизонтально
	for i in range(count):
		var hex = hex_scene.instantiate()
		hex.position = Vector2(i * spacing, -700)  # y = 0 (сверху)
		hex.data.color = "#00ff00"
		UnitColorManager.set_color(hex)
		add_child(hex)
		
	# Нижний ряд (жёлтые) — горизонтально
	for i in range(count):
		var hex = hex_scene.instantiate()
		hex.position = Vector2(i * spacing, 700)  # y = 400 (снизу)
		hex.data.color = "#ffff00"
		UnitColorManager.set_color(hex)
		add_child(hex)
		
	# Левый ряд (красные) — вертикально
	for i in range(count):
		var hex = hex_scene.instantiate()
		hex.position = Vector2(0, i * spacing)
		hex.data.color = "#ff0000"
		UnitColorManager.set_color(hex)
		add_child(hex)
		
	# Правый ряд (синие) — вертикально
	for i in range(count):
		var hex = hex_scene.instantiate()
		hex.position = Vector2(400, i * spacing)
		hex.data.color = "#0000ff"
		UnitColorManager.set_color(hex)
		add_child(hex)
		
	TurnManager.next_team()
