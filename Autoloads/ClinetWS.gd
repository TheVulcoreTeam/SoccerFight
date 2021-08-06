extends Node

# The URL we will connect to
export var websocket_url = "ws://127.0.0.1:3000" 
#export var websocket_url = "ws://echo.websocket.org" 

# Our WebSocketClient instance
var _client = WebSocketClient.new()

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed1")
	_client.connect("connection_error", self, "_closed2")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
func _process(delta):
	_client.poll()
	
func _closed1(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: 1", was_clean)
	set_process(false)
		
func _closed2(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: 2", was_clean)
	set_process(false)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	
	var dic = {
		"samu" : "monkey",
		"maty" : "dog"
	}
	
	var tjson = JSON.print(dic)
#	var json = JSON.parse(tjson)
	
	_client.get_peer(1).put_packet(tjson.to_utf8())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var st = _client.get_peer(1).get_packet().get_string_from_utf8()
	var dict = parse_json(st)
	print(dict["samu"])
#	var dictionary = Dictionary()
#	var yarn = dictionary["samu"]
#	print("Got data from server: ", yarn)
	
	

