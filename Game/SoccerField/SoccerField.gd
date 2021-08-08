extends Node2D

var ball_rec = preload("res://Game/Actors/Ball/Ball.tscn")

func _ready():
	Events.connect("respawn_ball", self, "_on_respawn_ball")


func _on_LeftGoal_body_entered(body):
	if body is Ball:
		Events.emit_signal("goal", null)
		SoundManager.play_sound("goal")
		body.destroy()


func _on_RightGoal_body_entered(body):
	if body is Ball:
		Events.emit_signal("goal", null)
		SoundManager.play_sound("goal")
		body.destroy()


func _on_respawn_ball():
	var center = get_viewport().size / 2
	var ball = ball_rec.instance()
	ball.global_position = center
	add_child(ball)
