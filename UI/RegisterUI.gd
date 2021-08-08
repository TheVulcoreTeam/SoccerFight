"""RegisterUI.gd"""

extends Control

var user_list = preload("res://UI/UserList.tscn").instance()

var client

func _ready():
	$Confirm.get_cancel().connect("pressed", self, "_on_close_modal")
#	yield(get_tree().create_timer(1.0), "timeout")
#	$Confirm.window_title = "PlayerX invite you. Do you accept?"
#	$Confirm.show()
#	yield(get_tree().create_timer(5.0), "timeout")
#	$Confirm.hide()
	
	
func _on_Multiplayer_pressed():
	
	if $"Background/VBox/YourNick".text.length() <= 3:
		return
	
	client = load("res://Autoloads/ClientWS.gd").new()
	client.set_register_ui(self)
	add_child(client)
	
	$"Background/VBox".hide()
	$Background.add_child(user_list)


func _on_SinglePlayer_pressed():
	if $"Background/VBox/YourNick".text.length() > 3:
		$"Background".hide()


func _on_Confirm_confirmed():
	print_debug("Confimed")
	$"Background".hide()
	var dic = {
		"eventName" : "answering",
		"data" : {
			"remote_player_key" : client.remote_player_key,
			"ok" : true
		}
	}
	client.sendDic(dic)
	

func reset_timer():
	$Waiting/VBoxContainer/ProgressBar.value = 0
	$Waiting/Timer.stop()
	$Waiting.hide()

func _on_Timer_timeout():
	if $Waiting/VBoxContainer/ProgressBar.value < 90:
		$Waiting/VBoxContainer/ProgressBar.value += 10
	else:
		var dic = {
		"eventName" : "timeout",
			"data" : {}
		}
		client.sendDic(dic)
		reset_timer()
		

func close_question():
	$Confirm.hide()
	print_debug("close_question")


func _on_close_modal():
	var dic = {
		"eventName" : "answering",
		"data" : {
			"remote_player_key" : client.remote_player_key,
			"ok" : false
		}
	}
	client.sendDic(dic)
