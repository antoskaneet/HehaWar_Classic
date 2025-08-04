extends Node

var _tilemaplayer
var _unit

func set_tilemaplayer(tilemaplayer: TileMapLayer):
	_tilemaplayer = tilemaplayer

func set_seleted_unit(unit: Node):
	_unit = unit

func get_movement_area() -> Array:
	var unit_pos = _unit.position
	var unit_pos_map = _tilemaplayer.local_to_map(unit_pos)
	var radius = _unit.data.radius
	
	var result = []
	var q0 = int(unit_pos_map.x)
	var r0 = int(unit_pos_map.y)
	
	# Добавляем центральную клетку
	var tile_pos = Vector2i(q0, r0)
	var has_grass = GridRegistry.get_hex(tile_pos, "grass")
	var has_unit = GridRegistry.get_hex(tile_pos, "unit")
	if has_grass and !has_unit:
		result.append(has_grass)
	
	# Итерация по слоям от 1 до radius
	for dist in range(1, radius + 1):
		# Смещения для соседей в порядке: верх, правый-верх, правый-низ, низ, левый-низ, левый-верх
		var directions = []
		if (q0 + dist) % 2 == 0:  # Чётный столбец
			directions = [
				Vector2i(0, -dist),        # верх
				Vector2i(1, 0 - dist + 1), # правый-верх
				Vector2i(1, dist),         # правый-низ
				Vector2i(0, dist),         # низ
				Vector2i(-1, dist),        # левый-низ
				Vector2i(-1, 0 - dist + 1) # левый-верх
			]
		else:  # Нечётный столбец
			directions = [
				Vector2i(0, -dist),        # верх
				Vector2i(1, -dist),        # правый-верх
				Vector2i(1, dist - 1),     # правый-низ
				Vector2i(0, dist),         # низ
				Vector2i(-1, dist - 1),    # левый-низ
				Vector2i(-1, -dist)        # левый-верх
			]
		
		# Добавляем клетки текущего слоя
		for dir in directions:
			var q = q0 + dir.x
			var r = r0 + dir.y
			tile_pos = Vector2i(q, r)
			has_grass = GridRegistry.get_hex(tile_pos, "grass")
			has_unit = GridRegistry.get_hex(tile_pos, "unit")
			if has_grass and !has_unit:
				result.append(has_grass)
	
	return result
