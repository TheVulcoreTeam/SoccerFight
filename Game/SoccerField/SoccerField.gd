extends Node2D

var ball_rec = preload("res://Game/Actors/Ball/Ball.tscn")
var player_rec = preload("res://Game/Actors/Player/Player.tscn")

func _ready():
	Events.connect("respawn_ball", self, "_on_respawn_ball")
	
	Main.player1 = player_rec.instance()
	Main.player2 = player_rec.instance()
	
	if Main.side:
		Main.player1.position.x = get_viewport().size.x * 0.25
		Main.player2.position.x = get_viewport().size.x * 0.75
	else:
		Main.player1.position.x = get_viewport().size.x * 0.75
		Main.player2.position.x = get_viewport().size.x * 0.25
	
	Main.player2.set_as_remote()
	
	Main.player1.position.y = get_viewport().size.y / 2
	add_child(Main.player1)

	Main.player2.position.y = get_viewport().size.y / 2
	add_child(Main.player2)


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
