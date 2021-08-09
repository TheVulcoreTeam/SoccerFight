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

func _on_player_impulse_event(impulse):
	
	var dic = {
		"eventName" : "my_impulse",
		"data" : {
			"impulse" : [impulse.x, impulse.y],
		}
	}
	
	if ClientManager.is_client_connected():
		ClientManager.get_current_client().sendDic(dic)
	
	
	pass

func _on_second_player_impulse_event(impulse):
	Main.player2.impulse.x = int(impulse[0])
	Main.player2.impulse.y = int(impulse[1])
	print_debug("hola")
