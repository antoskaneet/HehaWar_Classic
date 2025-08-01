extends Node

@onready var tilemap_layer = get_node("TileMapLayer")

func _ready() -> void:
	UnitSelector.set_tilemaplayer(tilemap_layer)
