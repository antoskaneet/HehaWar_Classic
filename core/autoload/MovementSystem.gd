extends Node

var hex_grid = HexGrid.new()
var tilemap_layer: TileMapLayer
var unit

func _ready() -> void:
	print("loaded MovementSystem")

func _init() -> void:
	print("load MovementSystem")

func set_tilemaplayer(tilemaplayer):
	tilemap_layer = tilemaplayer
	
func register_unit(unit: Node):
	self.unit = unit
	unit.unit_selected.connect(_on_unit_selected)
	print("Подписан на юнит: ", unit.name)

func _on_unit_selected(data: UnitData):
	print("Выбран юнит:")
	var radius = data.radius
	var position = unit.get_position()
	var coords = tilemap_layer.local_to_map(position)
	print(hex_grid.get_movement_area(coords, radius, tilemap_layer))
