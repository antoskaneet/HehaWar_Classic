extends Camera2D

var speed: float = 700
var dir: float = 0.1 

func _process(delta: float) -> void:
	self.position.x += dir * speed * delta
	
	if self.position.x >= 8900:
		dir = -0.1
	elif self.position.x <= 2700:
		dir = 0.1
