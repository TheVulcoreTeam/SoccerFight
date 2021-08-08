extends Node2D



func _on_LeftGoal_body_entered(body):

	if body.get_name() == "Ball":
		Events.emit_signal("goal", null)
		
	pass


func _on_RightGoal_body_entered(body):
	
	if body.get_name() == "Ball":
		Events.emit_signal("goal", null)
	
	pass 
