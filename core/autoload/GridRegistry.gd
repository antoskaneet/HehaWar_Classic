extends Node

var hexs: Dictionary = {}

var tilemap_layer: TileMapLayer

func set_tilemaplayer(tilemaplayer):
	tilemap_layer = tilemaplayer

func registry(node: Node, coords: Vector2i):
	var _local_coords = tilemap_layer.local_to_map(coords)
	if !hexs.has(_local_coords):
		hexs[_local_coords] = []
	if node not in hexs[_local_coords]:
		hexs[_local_coords].append(node)

func unregister(node: Node, coords: Vector2i) -> void:
	if hexs.has(coords):
		if node in hexs[coords]:
			hexs[coords].erase(node)
			if hexs[coords].is_empty():
				hexs.erase(coords)

func get_hex(coords: Vector2i, group_name: String) -> Node:
	if hexs.has(coords):
		for node in hexs[coords]:
			if node.is_in_group(group_name):
				return node
	return null

# НЕЭФФЕКТИВЕН: перебирает все ключи и значения словаря,
# что при большом количестве данных занимает много времени.
func find_key_by_value(target_node: Node):
	for coords in hexs.keys():
		if target_node in hexs[coords]:
			return coords
	return null
