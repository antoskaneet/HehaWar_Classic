extends Node

var hex_grid = HexGrid.new()

func register_unit(unit: Node):
	unit.unit_selected.connect(_on_unit_selected)
	print("Подписан на сигнал юнита: ", unit.name)

func _on_unit_selected(unit: Node):
	print("Выбран юнит:", unit)
	var mouse_pos_global = get_viewport().get_mouse_position()
	PathFinder.set_seleted_unit(unit)
	print("abobusi: tyt ", PathFinder.get_movement_area())
	#print("весь массив: ", GridRegistry.hexs)
	
