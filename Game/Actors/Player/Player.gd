extends RigidBody2D


const MAX_IMPULSE = 100

var impulse = Vector2.ZERO


func _physics_process(delta):
	$Sprite.look_at(get_global_mouse_position())
	

func _integrate_forces(state):
	print(impulse)
	
	if !impulse.is_equal_approx(Vector2.ZERO):
		impulse.x = clamp(impulse.x, -MAX_IMPULSE, MAX_IMPULSE)
		impulse.y = clamp(impulse.y, -MAX_IMPULSE, MAX_IMPULSE)
		
		state.apply_central_impulse(impulse)
		impulse = Vector2.ZERO
		print_debug(impulse)


func mouse_impulse():
	impulse = get_local_mouse_position()
#	print_debug(impulse)


func _input(event):
	if event.is_action_pressed("impulse"):
		mouse_impulse()
