extends Node

var event_effect = preload("res://Autoloads/EventEffect/EventEffect.tscn")

signal start_match

signal goal(who)

func _ready():
	connect("start_match", self, "_on_start_match_event")
	connect("goal", self, "_on_goal_event")

func _on_start_match_event():
	var effect = event_effect.instance()
	var center = get_viewport().size / 2
	add_child(effect)
	effect.position = center
	
	effect.play("START_MATCH")
	print("start match ...")

func _on_goal_event(who):
	var effect = event_effect.instance()
	var center = get_viewport().size / 2
	add_child(effect)
	effect.position = center
	
	effect.play("GOAL")
	print("goal ...")
