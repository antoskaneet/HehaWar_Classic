extends Node

var _tilemaplayer
var _unit
var movement_area_mass = []

func set_tilemaplayer(tilemaplayer: TileMapLayer):
	_tilemaplayer = tilemaplayer

func set_seleted_unit(unit: Node):
	_unit = unit

func is_walkable(pos: Vector2i) -> bool:
	var source_id = _tilemaplayer.get_cell_source_id(pos)
	if source_id == -1:
		return false
	var unit = GridRegistry.get_hex(pos, "unit")
	# print(unit)
	return !unit

func get_neighbors(pos: Vector2i) -> Array:
	var neighbors = []
	var parity = pos.x % 2

	var dy = -1 if parity == 0 else +1
	var directions = [
		Vector2i(+1, 0), Vector2i(-1, 0),
		Vector2i(0, -1), Vector2i(0, +1),
		Vector2i(+1, dy), Vector2i(-1, dy)
	]

	for dir in directions:
		neighbors.append(pos + dir)

	return neighbors

func get_units_in_range(max_steps: int) -> Array:
	var found_units := []
	var start = _tilemaplayer.local_to_map(_unit.position)
	var visited := { start: 0 }
	var frontier := [ { "pos": start, "cost": 0 } ]

	while frontier.size() > 0:
		var current = frontier.pop_front()
		var pos = current["pos"]
		var cost = current["cost"]

		if cost >= max_steps:
			continue

		for neighbor in get_neighbors(pos):
			if visited.has(neighbor) and visited[neighbor] <= cost + 1:
				continue

			visited[neighbor] = cost + 1
			frontier.append({ "pos": neighbor, "cost": cost + 1 })

			if neighbor != start:
				var unit_at_cell = GridRegistry.get_hex(neighbor, "unit")
				if unit_at_cell != null:
					found_units.append(unit_at_cell)

	return found_units



func get_unit_area(max_steps) -> Array:
	movement_area_mass.clear()
	var start = _tilemaplayer.local_to_map(_unit.position)
	var visited := { start: 0 }
	var frontier := [ { "pos": start, "cost": 0 } ]

	while frontier.size() > 0:
		var current = frontier.pop_front()
		var pos = current["pos"]
		var cost = current["cost"]

		if cost >= max_steps:
			continue

		for neighbor in get_neighbors(pos):
			if !is_walkable(neighbor):
				continue

			if visited.has(neighbor) and visited[neighbor] <= cost + 1:
				continue

			visited[neighbor] = cost + 1
			frontier.append({ "pos": neighbor, "cost": cost + 1 })

			var movement_area_cell = GridRegistry.get_hex(neighbor, "grass")
			movement_area_mass.append(movement_area_cell)
			
	return movement_area_mass

func get_path_move(unit: Node, grass: Node, grass_mass: Array) -> Array:
	var start_pos = _tilemaplayer.local_to_map(unit.position)
	var target_pos = _tilemaplayer.local_to_map(grass.position)
	
	# Множество допустимых клеток (Vector2i)
	var allowed_positions := {}
	for cell in grass_mass:
		var pos = _tilemaplayer.local_to_map(cell.position)
		allowed_positions[pos] = true
	
	# BFS
	var queue := [start_pos]
	var came_from := {}
	came_from[start_pos] = null
	
	while queue.size() > 0:
		var current = queue.pop_front()
		
		if current == target_pos:
			break
		
		for neighbor in get_neighbors(current):
			# Можно ходить только по grass_mass или стартовой клетке
			if !allowed_positions.has(neighbor) and neighbor != start_pos:
				continue
			if came_from.has(neighbor):
				continue
			
			came_from[neighbor] = current
			queue.append(neighbor)
	
	# Восстановление пути
	var path := []
	var cur = target_pos
	while cur != null:
		path.push_front(cur)
		cur = came_from.get(cur, null)
	
	# Убираем стартовую точку, если она есть
	if path.size() > 0 and path[0] == start_pos:
		path.remove_at(0)
	
	# Переводим координаты в ноды grass
	var path_nodes := []
	for pos in path:
		var grass_node = GridRegistry.get_hex(pos, "grass")
		if grass_node:
			path_nodes.append(grass_node)
	
	return path_nodes
