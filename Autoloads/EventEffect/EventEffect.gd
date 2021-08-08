extends Node


func _ready():
	
	
	
	pass # Replace with function body.

func play(effect : String):
	$Anim.play(effect)

func _on_end_anim():
	
	self.queue_free()
