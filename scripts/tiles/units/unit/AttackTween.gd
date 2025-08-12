extends Node

var tween: Tween
# спасибо нейронкам за такой "прекрасный" код
func attack_tween(attacker: Node2D, target: Node2D, forward_time := 0.15, back_time := 0.15):
	if tween:
		tween.kill()

	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	var start_pos = attacker.position
	var target_pos = target.position
	var dir = (target_pos - start_pos).normalized() * 10


	tween.tween_property(attacker, "position", start_pos + dir, forward_time)

	tween.tween_property(attacker, "position", start_pos, back_time)

	tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	print("Атака анимирована")
