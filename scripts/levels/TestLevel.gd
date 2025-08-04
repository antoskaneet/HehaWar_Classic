extends Node

@onready var tilemap_layer = get_node("TileMapLayer")

func _ready() -> void:
	GridRegistry.set_tilemaplayer(tilemap_layer)
	PathFinder.set_tilemaplayer(tilemap_layer)
