extends RefCounted

class_name HexGrid
	
func get_movement_area(hex_coord: Vector2, radius: int) -> Array:
	var result = []
	var q0 = int(hex_coord.x)
	var r0 = int(hex_coord.y)

	for dq in range(-radius, radius + 1):
		var r_min = max(-radius, -dq - radius)
		var r_max = min(radius, -dq + radius)
		for dr in range(r_min, r_max + 1):
			var q = q0 + dq
			var r = r0 + dr
			var tile_pos = Vector2i(q, r)

			var has_grass = GridRegistry.get_hex(tile_pos, "grass")
			var has_unit = GridRegistry.get_hex(tile_pos, "unit")

			if has_grass and not has_unit:
				result.append(has_grass)

	return result
	
