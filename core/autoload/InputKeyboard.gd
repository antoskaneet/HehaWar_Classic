extends Node

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		TurnManager.next_team()
