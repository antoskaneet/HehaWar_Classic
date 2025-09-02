extends Button

var last_click_time := 0.0
var double_click_threshold := 0.3

func _ready() -> void:
	toggle_mode = true
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var now := Time.get_ticks_msec() / 1000.0
	if now - last_click_time < double_click_threshold:
		Network.join_game("127.0.0.1") # ВАЖНО ИЗМЕНИТЬ IP
		get_tree().change_scene_to_file("res://scenes/ui/lobby/Lobby.tscn")
	else:
		button_pressed = true
	last_click_time = now
