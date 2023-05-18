extends TouchScreenButton






var colors = ["res://caterpillar/redCircle.png","res://caterpillar/blueCircle.png","res://caterpillar/yellowCircle.png"]
var index = 0
var x = 1
func _caterpillar(i):
	for a in range(i):
		var circle = Sprite2D.new()
		circle.texture = load(colors[index])
		index = index+1
		if index == 3:
			index = 0
		var smiley = get_tree().get_nodes_in_group("caterpillar")[0]
		circle.position = to_local(smiley.position) + Vector2((60*x),0)
		x = x+1
		circle.z_index = circle.z_index-(1*x)
		add_child(circle)
func _on_pressed():
	#$"../levels menu".enabled = true
	#$"../levels menu".make_current()
