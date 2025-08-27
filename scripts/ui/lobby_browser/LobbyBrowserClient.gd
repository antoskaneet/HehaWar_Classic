extends Node

var udp_peer: PacketPeerUDP
var discover: bool = true
var lobby_path 
var discover_timer = Timer.new()

func _ready():
	udp_peer = PacketPeerUDP.new()
	udp_peer.set_broadcast_enabled(true)
	udp_peer.bind(12345)
	print("Клиент готов")
	

	discover_timer.wait_time = 0.5
	discover_timer.one_shot = false
	discover_timer.autostart = true
	discover_timer.timeout.connect(self._send_discover)
	add_child(discover_timer)

func _process(_delta):
	while udp_peer.get_available_packet_count() > 0:
		var pkt = udp_peer.get_packet().get_string_from_utf8()
		var parser = JSON.new()
		if parser.parse(pkt) == OK:
			var data = parser.data
			print("Ответ от сервера: ", data)
			if data.get("discover", false) == false:
				discover = false
				discover_timer.stop()
				add_server_to_list(data)

func _send_discover():
	udp_peer.set_dest_address("255.255.255.255", 12344)
	udp_peer.put_packet("DISCOVER".to_utf8_buffer())
	print("DISCOVER отправлен")
	
func add_server_to_list(server_info: Dictionary):
	var path = server_info.get("lobby_path", "")
	if path == "":
		return
	
	var server_name = server_info.get("server_name", "Unknown")
	var scene_res = load(path)
	if not scene_res:
		return

	var server_item = scene_res.instantiate()

	var list_parent = get_parent().get_node("MarginContainer/VBoxContainer/VBoxContainer/LobbyPanel/ScrollContainer/VBoxContainer")
	list_parent.add_child(server_item)
	server_item.set_data(server_name)
	
	LobbyData.ip = server_info.get("ip")
	print(LobbyData.ip)
	
	
# ПРИМЕР ПАКЕТА
#"server_name": LobbyData.server_name,
#"password": LobbyData.password,
#"lobby_path": "res://scenes/ui/lobby_browser/ServerListItem.tscn",
#"discover": false,
