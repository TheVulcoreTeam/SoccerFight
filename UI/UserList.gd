extends Control

var parent

func set_users_names(user_dic, _parent = null):
	if _parent:
		parent = _parent
	
	for element in user_dic:
		var buttom = Button.new()
		buttom.text = element
		buttom.connect("pressed", self, "on_pressed")
		$VBox.add_child(buttom)

func on_pressed():
	parent.get_node("Waiting").show()
	parent.get_node("Waiting/Timer").start()
#	parent.get_node("Background").hide()

