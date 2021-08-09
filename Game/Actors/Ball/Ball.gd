extends RigidBody2D

class_name Ball

var remote_data = null
var current_position = Vector2.ZERO
var current_linear_velocity = Vector2.ZERO
var remote_velocity = Vector2.ZERO

func destroy():
	$Anim.play("Dead")


func _on_Anim_animation_finished(anim_name):
	Events.emit_signal("respawn_ball")
	queue_free()
	
func _integrate_forces(state):
	current_position = state.get_transform().origin
	current_linear_velocity = state.get_linear_velocity()
	
	if remote_data != null :
		var t = Transform2D()
		t.origin.x = int(remote_data["position"][0])
		t.origin.y = int(remote_data["position"][1])
		state.set_transform(t)
		
		remote_velocity.x = int(remote_data["velocity"][0])
		remote_velocity.y = int(remote_data["velocity"][1])
		state.set_linear_velocity(remote_velocity)
	
		remote_data = null
