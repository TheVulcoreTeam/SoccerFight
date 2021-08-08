extends RigidBody2D

class_name Ball

func destroy():
	$Anim.play("Dead")


func _on_Anim_animation_finished(anim_name):
	Events.emit_signal("respawn_ball")
	queue_free()
