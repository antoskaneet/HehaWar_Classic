extends Node

@onready var grass = self

func _ready() -> void:
	add_to_group("grass")
	GridRegistry.registry(grass, grass.global_position)

func bob():
	self.queue_free()
