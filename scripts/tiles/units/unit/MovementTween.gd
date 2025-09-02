extends Node

var tween: Tween


func move_along_path(path: Array, duration_per_cell := 0.3):
	
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	for grass_node in path:
		tween.tween_property(owner, "global_position", grass_node.global_position, duration_per_cell)


	tween.finished.connect(_on_tween_finished)


func _on_tween_finished():
	print(TeamManager.get_team("#ff0000"))
	get_parent().get_node("InputUnit").visible = true
	get_parent().call_rpc_remote_set_position()
	#get_parent().get_node("Sprite2D").modulate = Color.html("#3366FF")
