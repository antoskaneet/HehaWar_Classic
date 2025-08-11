extends RefCounted

class_name Attack
	
func set_attack_area(attack_area: Array):
	for _unit in attack_area:
		_unit.get_node("UnitState").activate()
	
func remove_attack_area(attack_area: Array):
	for _unit in attack_areas:
		_unit.get_node("UnitState").un_activate()
		
func attack(_unit, target_tile, attack_area):
