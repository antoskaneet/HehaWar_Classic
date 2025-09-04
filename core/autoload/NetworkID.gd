extends Node

var _next_id: int = 1

#func _ready():
	#if multiplayer.is_server():
		

func get_unique_id() -> int:
	var id = _next_id
	_next_id += 1
	return id
