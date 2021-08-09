extends RigidBody2D


const MAX_IMPULSE = 300

var impulse = Vector2.ZERO
var mouse_position = Vector2.ZERO
var current_position = Vector2.ZERO
var remote_impulse = Vector2.ZERO
var remote_mouse_position = Vector2.ZERO

var remote_data = null
var remote_user = false

var triger = false

func _physics_process(delta):
	if !remote_user:
		$Sprite.look_at(get_global_mouse_position())

"""LOOP"""
func _integrate_forces(state):
	if remote_data != null && remote_user:
#		print(remote_data)
		process_remote_data(state) #1
		remote_data = null #2
	
	if triger:
		current_position = state.get_transform().origin
		
		var ball_data = {
			"velocity": Main.ball.current_linear_velocity,
			"position": Main.ball.current_position,
		}
		
		Events.emit_signal("player_impulse", [
			impulse, 
			current_position, 
			mouse_position, 
			ball_data
		])
		
		state.set_linear_velocity(Vector2.ZERO)
		state.apply_central_impulse(impulse)
#		print(state.get_linear_velocity())
		
		triger = false
		
	
		
		
func process_remote_data(state):
	var t = Transform2D()
	t.origin.x = int(remote_data["position"][0])
	t.origin.y = int(remote_data["position"][1])
	state.set_transform(t)
	
	remote_impulse.x = int(remote_data["impulse"][0])
	remote_impulse.y = int(remote_data["impulse"][1])
	state.set_linear_velocity(Vector2.ZERO)
	state.apply_central_impulse(remote_impulse)
		
	remote_mouse_position.x = int(remote_data["mouse"][0])
	remote_mouse_position.y = int(remote_data["mouse"][1])
	$Sprite.look_at(remote_mouse_position)
	
	Main.ball.remote_data = remote_data["ball"]
			

func _input(event):
	if event.is_action_pressed("impulse"):
		if !remote_user:
			triger = true
			mouse_position = get_local_mouse_position()
			impulse.x = clamp(mouse_position.x, -MAX_IMPULSE, MAX_IMPULSE)
			impulse.y = clamp(mouse_position.y, -MAX_IMPULSE, MAX_IMPULSE)


func set_as_remote():
	remote_user = true
