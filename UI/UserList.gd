extends Control

var parent
func set_users_names(user_dic, _parent):
	parent = _parent
	for element in user_dic.values():
		var buttom = Button.new()
		buttom.text = element
		buttom.connect("pressed", self, "on_pressed")
		$VBox.add_child(buttom)

func on_pressed():
	parent.get_node("Background").hide()

