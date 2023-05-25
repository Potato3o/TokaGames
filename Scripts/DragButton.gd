extends TouchScreenButton






var colorsX = [368.391,370.163,368.391]
var colorsY = [183.73,18.974,569.161]
var colorsW = [122.238,122.238,124.009]
var colorsH = [134.639,138.182,136.41]
var atlas
var index = 0
var x = 1
func _caterpillar(i):
	for a in range(i):
		atlas = AtlasTexture.new()
		var circle = Sprite2D.new()
		atlas.atlas = load("res://caterpillarSprites.png")
		atlas.region = Rect2(colorsX[index],colorsY[index],colorsW[index],colorsH[index],)
		circle.texture = atlas
		index = index+1
		if index == 3:
			index = 0
		var smiley = get_tree().get_nodes_in_group("caterpillar")[0]
		circle.position = to_local(smiley.position) + Vector2((60*x),0)
		x = x+1
		circle.z_index = circle.z_index-(x)
		add_child(circle)
func _on_pressed():
	#$"../levels menu".enabled = true
	#$"../levels menu".make_current()
	_caterpillar(1)
