extends Node

var udp_peer: PacketPeerUDP
var server_info

func _ready():
	if LobbyData.is_host:
		server_info = {
			"server_name": LobbyData.server_name,
			"password": LobbyData.password,
			"lobby_path": "res://scenes/ui/lobby_browser/ServerListItem.tscn",
			"discover": false,
		}
		
		udp_peer = PacketPeerUDP.new()
		udp_peer.bind(12344)
		udp_peer.set_broadcast_enabled(true)
		print("Сервер готов, слушаем")

func _process(delta):
	while udp_peer.get_available_packet_count() > 0:
		var pkt = udp_peer.get_packet().get_string_from_utf8()
		var client_ip = udp_peer.get_packet_ip()
		var client_port = udp_peer.get_packet_port()

		print("Получен DISCOVER от %s:%d -> %s" % [client_ip, client_port, pkt])

		if pkt == "DISCOVER":
			var json = JSON.stringify(server_info)
			udp_peer.set_dest_address(client_ip, client_port) # отправляем туда, откуда пришёл запрос
			udp_peer.put_packet(json.to_utf8_buffer())
			print("Отправили JSON клиенту -> ", client_ip, ":", client_port)
