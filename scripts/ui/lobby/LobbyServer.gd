extends Node

var udp_peer: PacketPeerUDP
var server_info
var ipv4

func _ready():
	set_process(false)
	if LobbyData.is_host:
		ipv4 = search_vpn_ipv4()
		server_info = {
			"server_name": LobbyData.server_name,
			"password": LobbyData.password,
			"lobby_path": "res://scenes/ui/lobby_browser/ServerListItem.tscn",
			"discover": false,
			"ip": ipv4,
		}
		print("вот ано, ", ipv4)
		
		udp_peer = PacketPeerUDP.new()
		udp_peer.bind(12344)
		udp_peer.set_broadcast_enabled(true)
		print("Сервер готов, слушаем")
		Network.create_server()
		set_process(true)


func search_vpn_ipv4() -> String:
	var addresses = IP.get_local_addresses()
	for addr in addresses:
		# IPv4 и RadminVPN адреса начинаются с 26.
		if addr.begins_with("26."):
			return addr
	# Если VPN не найден, берём обычный LAN
	for addr in addresses:
		if "." in addr and (addr.begins_with("192.") or addr.begins_with("10.") or addr.begins_with("172.")):
			return addr
	# На крайний случай первый адрес
	if addresses.size() > 0:
		return addresses[0]
	return ""


func _process(delta):
	while udp_peer.get_available_packet_count() > 0:
		var pkt = udp_peer.get_packet().get_string_from_utf8()
		var client_ip = udp_peer.get_packet_ip()
		var client_port = udp_peer.get_packet_port()

		print("Получен DISCOVER от %s:%d -> %s" % [client_ip, client_port, pkt])

		if pkt == "DISCOVER":
			var json = JSON.stringify(server_info)
			udp_peer.set_dest_address(client_ip, client_port)
			udp_peer.put_packet(json.to_utf8_buffer())
			print("Отправили JSON клиенту -> ", client_ip, ":", client_port)
