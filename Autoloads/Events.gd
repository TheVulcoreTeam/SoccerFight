extends Node

var event_effect = preload("res://Autoloads/EventEffect/EventEffect.tscn")

signal start_match
signal respawn_ball
signal goal(who)
signal player_impulse(impulse)
signal second_player_impulse(impulse)

var players
var second_player

func _ready():
	connect("start_match", self, "_on_start_match_event")
	connect("goal", self, "_on_goal_event")
	connect("player_impulse", self, "_on_player_impulse_event")
	connect("second_player_impulse", self, "_on_second_player_impulse_event")


func _on_start_match_event():
	var effect = event_effect.instance()
	var center = get_viewport().size / 2
	add_child(effect)
	effect.position = center
	
	effect.play("START_MATCH")


func _on_goal_event(who):
	var effect = event_effect.instance()
	var center = get_viewport().size / 2
	add_child(effect)
	effect.position = center
	
	effect.play("GOAL")

"""SENDER"""
func _on_player_impulse_event(data):
	
	var dic = {
		"eventName" : "my_impulse",
		"data" : {
			"impulse" : [data[0].x, data[0].y],
			"position" : [data[1].x, data[1].y],
			"mouse" : [data[2].x, data[2].y],
			"ball" : {
				"velocity" : [data[3]["velocity"].x, data[3]["velocity"].y],
				"position" : [data[3]["position"].x, data[3]["position"].y],	
			},
		}
	}
	if ClientManager.is_client_connected():
		ClientManager.get_current_client().sendDic(dic)	
	
"""RECEIVER"""
func _on_second_player_impulse_event(data):
	Main.player2.remote_data = data
#	Main.Player2.remote_impulse.x = int(data["impulse"][0])
#	Main.player2.remote_impulse.y = int(data["impulse"][1])
#	Main.player2.remote_player_position.x = int(data["position"][0])
#	Main.player2.remote_player_position.y = int(data["position"][1])	
#	Main.player2.mouse_position.x = int(data["mouse"][0])
#	Main.player2.mouse_position.y = int(data["mouse"][1])

	
