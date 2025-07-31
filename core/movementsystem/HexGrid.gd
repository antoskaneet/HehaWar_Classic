extends RefCounted

class_name HexGrid
	
func get_movement_area(hex_coord: Vector2, radius: int, tilemap_layer: TileMapLayer) -> Array:
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

			var tile_data = tilemap_layer.get_cell_source_id(tile_pos)
			if tile_data != -1:
				result.append(Vector2(q, r))

	return result
