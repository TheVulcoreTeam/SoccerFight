extends Control

var user_list = preload("res://UI/UserList.tscn").instance()

func _ready():
	pass

func _on_Multiplayer_pressed():
	if $"Background/VBox/YourNick".text.length() <= 3:
		return
	var user_dic = {
		"1":"player1",
		"2":"player2",
		"3":"player3",
	}
	user_list.set_users_names(user_dic, self)
	$"Background/VBox".hide()
	$Background.add_child(user_list)


func _on_SinglePlayer_pressed():
	if $"Background/VBox/YourNick".text.length() > 3:
		$"Background".hide()	
