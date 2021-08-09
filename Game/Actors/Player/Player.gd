extends RigidBody2D


const MAX_IMPULSE = 70

var impulse = Vector2.ZERO


func _physics_process(delta):
	$Sprite.look_at(get_global_mouse_position())


func _integrate_forces(state):
	if !impulse.is_equal_approx(Vector2.ZERO):
		impulse.x = clamp(impulse.x, -MAX_IMPULSE, MAX_IMPULSE)
		impulse.y = clamp(impulse.y, -MAX_IMPULSE, MAX_IMPULSE)
		
		state.apply_central_impulse(impulse)
		impulse = Vector2.ZERO


func mouse_impulse():
	impulse = get_local_mouse_position()
	Events.emit_signal("player_impulse", impulse)

func _input(event):
	if event.is_action_pressed("impulse"):
		mouse_impulse()


#func _on_Player_body_entered(body):
##	if body is Ball:
		


