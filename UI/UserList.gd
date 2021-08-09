extends Control

var parent
var client

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
		
func set_users_names(user_dic, _parent = null, _client = null):
	if _parent:
		parent = _parent
	if _client:
		client = _client
	delete_children($VBox)
	
	for element in user_dic:
		
		if(parent.get_node("Background/VBox/YourNick").text == user_dic[element]["nick"]):
			continue
		if user_dic[element]["status"] == 1: 
			var buttom = Button.new()
#			buttom.text = str( user_dic[element]["nick"] + " " + str(user_dic[element]["status"]))
			buttom.text = str( user_dic[element]["nick"] )
			buttom.connect("pressed", self, "on_pressed",[element] )
			$VBox.add_child(buttom)
			continue
		if user_dic[element]["status"] == 2: 
			var buttom = Button.new()
#			buttom.text = str( user_dic[element]["nick"] + " " + str(user_dic[element]["status"]))
			buttom.text = str( user_dic[element]["nick"])
			$VBox.add_child(buttom)
			continue
		
		if user_dic[element]["status"] == 4: 
			if(parent.get_node("Background/VBox/YourNick").text == user_dic[element]["nick"]):
				parent.get_node("Confirm").show()
			var buttom = Button.new()
#			buttom.text = str( user_dic[element]["nick"] + " " + str(user_dic[element]["status"]))
			buttom.text = str( user_dic[element]["nick"] )
			$VBox.add_child(buttom)
			continue
		

func on_pressed(id):
	parent.get_node("Waiting").show()
	parent.get_node("Waiting/Timer").start()
	var dic = {
		"eventName" : "invite",
		"data" : {
			"secWebsocketId" : id
		}
	}
	client.sendDic(dic)

