extends Node

func play(effect : String):
	$Anim.play(effect)
	SoundManager.play_sound("goal")

func _on_end_anim():
	self.queue_free()
