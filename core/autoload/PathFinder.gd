extends Node

var _tilemaplayer
var _unit
var movement_area_mass = []

func set_tilemaplayer(tilemaplayer: TileMapLayer):
	_tilemaplayer = tilemaplayer

func set_seleted_unit(unit: Node):
	_unit = unit

func is_walkable(pos: Vector2i) -> bool:
	var unit = GridRegistry.get_hex(pos, "unit")
	print(unit)
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

func get_movement_area(unit: Node) -> Array:
	movement_area_mass.clear()
	var start = _tilemaplayer.local_to_map(_unit.position)
	var max_steps = _unit.data.radius
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

func get_path_move(grass: Node):
	#в процессе
	return
