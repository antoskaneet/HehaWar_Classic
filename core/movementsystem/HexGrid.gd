extends RefCounted

# ето типо Movement, лень менять названия
class_name HexGrid
	
func set_movement_area(grass_mass: Array):
	for grass in grass_mass:
		grass.activate()
	
func remove_movement_area(grass_mass: Array):
	for grass in grass_mass:
		grass.un_activate()
		
func move(_unit, grass, grass_mass):
	var finish = grass.position
	_unit.position = finish
	remove_movement_area(grass_mass)
