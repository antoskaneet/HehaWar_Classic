extends Node

var tcp_server : TCPServer
var udp : UDPServer
var peers := []

func _ready() -> void:
	print("host_is = ", LobbyData.is_host)
	print("password = ", LobbyData.password)
	print("server_name = ", LobbyData.server_name)

	if LobbyData.is_host == true:
		# Создаём TCP сервер
		tcp_server = TCPServer.new()
		var err = tcp_server.listen(54321)
		if err != OK:
			print("Ошибка запуска TCP сервера:", err)
		
		# Создаём UDP сервер для broadcast
		udp = UDPServer.new()
		udp.listen(12345)
		
		# Однократный broadcast IP хоста
		test_udp_all()


func test_udp_all():
	var host_ip = IP.get_local_addresses()[0]
	var msg = host_ip.to_utf8_buffer()
	udp.set_dest_address("255.255.255.255", 12345)
	udp.put_packet(msg)
	print("UDP broadcast отправлен:", host_ip)


func _process(delta):
	if udp:
		udp.poll()
		while udp.is_connection_available():
			var peer = udp.take_connection()
			var packet = peer.get_packet()
			var client_ip = packet.get_string_from_utf8()
			print("Получен пакет от:", client_ip)
	
	if tcp_server:
		if tcp_server.is_connection_available():
			var client = tcp_server.take_connection() as StreamPeerTCP
			peers.append(client)
			print("TCP клиент подключился!")
