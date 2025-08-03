extends Node

var hex_grid = HexGrid.new()
var tilemap_layer: TileMapLayer

func set_tilemaplayer(tilemaplayer):
	tilemap_layer = tilemaplayer
	
func register_unit(unit: Node):
	unit.unit_selected.connect(_on_unit_selected)
	print("Подписан на сигнал юнита: ", unit.name)

func _on_unit_selected(unit: Node):
	print("Выбран юнит:", unit)
	var radius = unit.data.radius
	var position = unit.get_position()
	var coords = tilemap_layer.local_to_map(position)
	print(hex_grid.get_movement_area(coords, radius, tilemap_layer))
