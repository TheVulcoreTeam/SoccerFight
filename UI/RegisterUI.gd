extends Control

var user_list = preload("res://UI/UserList.tscn").instance()

func _ready():
	pass


func _on_Multiplayer_pressed():
	$"Background/VBox".hide()
	$Background.add_child(user_list)
