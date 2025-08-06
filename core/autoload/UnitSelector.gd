extends Node

var hex_grid = HexGrid.new()
var grass_mass: Array
var current_unit: Node

func register_unit(unit: Node):
	unit.unit_selected.connect(_on_unit_selected)
	print("Подписан на сигнал юнита: ", unit.name)
	
func register_grass(grass: Node):
	grass.grass_selected.connect(_on_hex_grass_selected)

func _on_unit_selected(unit: Node):
	print("Выбран юнит:", unit)
	PathFinder.set_seleted_unit(unit)
	hex_grid.remove_movement_area(grass_mass)
	grass_mass = PathFinder.get_movement_area(unit)
	hex_grid.set_movement_area(grass_mass)
	current_unit = unit
	
func _on_hex_grass_selected(grass: Node):
	hex_grid.move(current_unit, grass, grass_mass)
