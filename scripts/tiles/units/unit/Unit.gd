extends Node

var data = UnitData.new()
var network_position: Vector2
var target_position: Vector2

func _ready():
	add_to_group("unit")
	TeamManager.add_unit_to_team(self)
	GridRegistry.registry(self, self.global_position)
	InputManager.disable_input(self.get_node("InputUnit"), "right_click_select")
	target_position = self.global_position
	set_process(false)

@rpc("any_peer", "reliable")
func remote_set_position(authority_position):
	self.global_position = authority_position

func call_rpc_remote_set_position():
	rpc("remote_set_position", self.global_position)
