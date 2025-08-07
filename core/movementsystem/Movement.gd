extends RefCounted

class_name Movement
	
func set_movement_area(grass_mass: Array):
	for grass in grass_mass:
		grass.activate()
	
func remove_movement_area(grass_mass: Array):
	for grass in grass_mass:
		grass.un_activate()
		
func move(_unit, grass, grass_mass):
	var finish = grass.position
	GridRegistry.unregistry(_unit, _unit.position)
	remove_movement_area(grass_mass)
	GridRegistry.registry(_unit, finish)
	_unit.position = finish
