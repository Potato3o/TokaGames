extends Node2D

#number of children
var max = 0

#how many buttons have been pressed, and what their pressed state is
var count = 0
var checkBox = []

#redraws these vectors 
var vectorArray = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.z_index = 0
	#sets child count and states
	max = self.get_child_count()
	checkBox.resize(max)
	checkBox.fill(false)
	
	#connects pressed signal to self 
	for i in self.get_children():
		i.connect("pressed",tracepressed)
	for i in $"../WrongAreas".get_children():
		i.connect("pressed",clearOut)

#resets all arrays and counts
func clearOut():
	vectorArray.clear()
	checkBox.fill(false)
	count = 0


#when a trace button is pressed
func tracepressed():
	for i in range(self.get_child_count()):
		var child = self.get_child(i)
		if child.is_pressed() && (checkBox[i] == false):
			count += 1
			checkBox[i] = true
			vectorArray.append(child.position)
			queue_redraw()
	if count >= max:
		get_parent().get_parent().cardNumber += 1
		get_parent().get_parent().newCard()
		vectorArray.clear()
		queue_free()

func _draw():
	for i in vectorArray:
		draw_circle(i,10,Color.YELLOW)


