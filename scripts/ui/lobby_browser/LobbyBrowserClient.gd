extends Node

var udp : UDPServer
var tcp_client : StreamPeerTCP
var connected := false

func _ready() -> void:
	udp = UDPServer.new()
	udp.listen(12345)

func _process(delta: float) -> void:
	if udp:
		udp.poll()
		while udp.is_connection_available():
			var peer = udp.take_connection()
			var packet = peer.get_packet()
			var host_ip = packet.get_string_from_utf8()
			print("Хост найден по IP:", host_ip)
			
			if not connected:
				tcp_client = StreamPeerTCP.new()
				var err = tcp_client.connect_to_host(host_ip, 54321)
				if err == OK:
					print("Подключились к хосту")
					connected = true
