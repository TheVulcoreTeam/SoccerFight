extends Node

# The URL we will connect to
export var websocket_url = "ws://localhost:3000"

# Our WebSocketClient instance
var _client = WebSocketClient.new()
var register_ui
var remote_player_key
var remote_player_name

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)


func set_register_ui(_register_ui):
	register_ui = _register_ui


func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)


func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print_debug("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	
	var dic = {
		"eventName" : "login",
		"data" : {
			"name" : register_ui.get_node("Background/VBox/YourNick").text,
		}
	}
	sendDic(dic)


func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var st = _client.get_peer(1).get_packet().get_string_from_utf8()
	var dict = parse_json(st)
	
	if dict["eventName"] == "user-list":
		register_ui.user_list.set_users_names(dict["data"], register_ui, self)
		return
	
	if dict["eventName"] == "close-question":
		register_ui.close_question()
		return
	
	if dict["eventName"] == "invited":
		remote_player_key = dict["data"]["remote_player"]
		remote_player_name = dict["data"]["remote_player_name"]
		register_ui.get_node("Confirm").window_title = remote_player_name + " invite you. Do you accept?"
		register_ui.get_node("Confirm").show()
		return

	if dict["eventName"] == "rejected":
		register_ui.reset_timer()
		return
	
func sendDic(dic):
	var tjson = JSON.print(dic)
	_client.get_peer(1).put_packet(tjson.to_utf8())
	
		
func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()
