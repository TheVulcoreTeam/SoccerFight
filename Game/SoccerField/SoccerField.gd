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
	Main.ball =  $Ball

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

func spawn_ball():
	var ball = ball_rec.instance()
	ball.global_position = Vector2(1088/2, 704/2)
	add_child(ball)
	Main.ball =  ball
	
	
func _on_respawn_ball():
	spawn_ball()
	
func _process(delta):
	if Main.player1:
		var _string = str(ceil(Main.player1.time))
		if _string == "0":
			_string = "Go"
			$Label.modulate = Color( 1, 0, 0, 1 )
		else:
			$Label.modulate = Color( 1, 1, 1, 1 )
		$Label.text = _string


func _on_Button_toggled(button_pressed):
	if button_pressed:
		Main.environment_sound.volume_db = -60
		#		sound.
	else:
		Main.environment_sound.volume_db = -20
