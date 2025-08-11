extends RefCounted

class_name Movement
	
func set_movement_area(grass_mass: Array):
	for grass in grass_mass:
		grass.activate()
	
func remove_movement_area(grass_mass: Array):
	for grass in grass_mass:
		grass.un_activate()
		
func move(_unit, target_tile, grass_mass):
	_unit.get_node("InputUnit").visible = false
	var path = PathFinder.get_path_move(_unit, target_tile, grass_mass)
	if path.is_empty():
		return
	_unit.get_node("MovementTween").move_along_path(path)
	
	GridRegistry.unregistry(_unit, _unit.position)
	remove_movement_area(grass_mass)
	GridRegistry.registry(_unit, target_tile.position)
