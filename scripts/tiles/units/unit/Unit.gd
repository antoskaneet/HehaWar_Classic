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
	_ready_network_server()

	
	

func _ready_network_server():
	if multiplayer.is_server():
		print("Инициализация сети сервера юнита")
		var _network_id = NetworkID.get_unique_id()


		self.data.network_id = _network_id
		GridRegistry.registry_network_id(self, _network_id)

		_receive_id.rpc_id(0, _network_id)

#func _send_id_rpc():
	#if multiplayer.is_server():
		#print("сервер отправил рпс")
		#var _network_id = NetworkID.get_unique_id()
		#_receive_id.rpc(_network_id)

@rpc("any_peer", "reliable")
func _receive_id(id: int):
	if !multiplayer.is_server():
		print("Получил ID от сервера:", id)
		self.data.network_id = id
		GridRegistry.registry_network_id(self, id)

@rpc("any_peer", "reliable")
func remote_set_position(authority_position):
	self.global_position = authority_position

func call_rpc_remote_set_position():
	rpc("remote_set_position", self.global_position)
