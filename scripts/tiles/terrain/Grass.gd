extends Node

@onready var grass_input = $GrassInput
@onready var grass = self

signal grass_selected(grass: Node)


func _ready() -> void:
	add_to_group("grass")
	GridRegistry.registry(grass, grass.global_position)
	grass_input.grass_selected.connect(_on_hex_grass_selected)
	UnitSelector.register_grass(self)

func activate():
	grass_input.visible = true
	grass_input.monitoring = true
	$GrassTexture.texture = preload("res://assets/blackhex.png")
	
func un_activate():
	grass_input.visible = false
	grass_input.monitoring = false
	$GrassTexture.texture = preload("res://assets/bluehex.png")

func _on_hex_grass_selected():
	emit_signal("grass_selected", grass)
