extends Node

var hex_grid = HexGrid.new()

func register_unit(unit: Node):
	unit.unit_selected.connect(_on_unit_selected)
	print("Подписан на сигнал юнита: ", unit.name)

func _on_unit_selected(unit: Node):
	print("Выбран юнит:", unit)
	PathFinder.set_seleted_unit(unit)
	PathFinder.get_reachable_tiles(unit)
	#print("весь массив: ", GridRegistry.hexs)
	
