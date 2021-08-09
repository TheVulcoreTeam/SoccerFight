extends Node

var current_client : ClientWS = null

func get_current_client():
	if current_client == null:
		print_debug("Error: Se intenta acceder a un cliente inexistente...")
	return current_client

func create_new_client() -> ClientWS:
	current_client = ClientWS.new()
	add_child(current_client)
	return current_client

func is_client_connected() -> bool:
	return current_client != null
