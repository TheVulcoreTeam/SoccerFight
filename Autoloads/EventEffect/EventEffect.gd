extends Node

func play(effect : String):
	$Anim.play(effect)

func _on_end_anim():
	self.queue_free()
