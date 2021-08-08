extends Control

var user_list = preload("res://UI/UserList.tscn").instance()


func _ready():
	yield(get_tree().create_timer(5.0), "timeout")
	$Confirm.window_title = "PlayerX invite you. Do you accept?"
	$Confirm.show()
	yield(get_tree().create_timer(5.0), "timeout")
	$Confirm.hide()



func _on_Multiplayer_pressed():
	
	if $"Background/VBox/YourNick".text.length() <= 3:
		return
	
	var client = load("res://Autoloads/ClientWS.gd").new()
	client.set_register_ui(self)
	add_child(client)
	
	$"Background/VBox".hide()
	$Background.add_child(user_list)


func _on_SinglePlayer_pressed():
	if $"Background/VBox/YourNick".text.length() > 3:
		$"Background".hide()


func _on_Confirm_confirmed():
	$"Background".hide()


func _on_Timer_timeout():
	if $Waiting/VBoxContainer/ProgressBar.value < 90:
		$Waiting/VBoxContainer/ProgressBar.value += 10
	else:
		$Waiting/VBoxContainer/ProgressBar.value = 0
		$Waiting/Timer.stop()
		$Waiting.hide()
		
