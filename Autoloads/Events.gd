extends Node

var event_effect = preload("res://Autoloads/EventEffect/EventEffect.tscn")

signal start_match

signal goal(player)

func _ready():
	connect("start_match", self, "_on_start_match_event")
	connect("goal", self, "_on_goal_event")

func _on_start_match_event():
	var effect = event_effect.instance()
	var center = get_viewport().get_rect().size / 2
	
	effect.position = center
	
	effect.play("START_MATCH")

func _on_goal_event(player):
	var effect = event_effect.instance()
	var center = get_viewport().get_rect().size / 2
	
	effect.position = center
	
	effect.play("goal")

