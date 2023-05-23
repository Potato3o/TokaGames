extends Node2D

#number of children
var max = 0

#how many buttons have been pressed, and what their pressed state is
var count = 0
var checkBox = []

var buttonArray = []
#redraws these vectors 
var vectorArray = []

var startpoint = Vector2.ZERO
var stoppoint = Vector2.ZERO
var countpoint = 0
var countdown = 0 
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
	buttonArray.clear()
	checkBox.fill(false)
	count = 0


#when a trace button is pressed
func tracepressed():
	for i in range(self.get_child_count()):
		var child = self.get_child(i)
		if child.is_pressed() && (checkBox[i] == false):
			count += 1
			checkBox[i] = true
			buttonArray.append(child.position)
			queue_redraw()
	if count >= max:
		get_parent().get_parent().cardNumber += 1
		get_parent().get_parent().newCard()
		vectorArray.clear()
		queue_free()

func _draw():
	for v in buttonArray:
		draw_circle(v,10,Color.RED)
	for i in vectorArray:
		draw_line(i[0],i[1],Color.YELLOW,5)
		
func _input(event):
	if event is InputEventScreenDrag:
		var local_event = make_input_local(event)
		stoppoint = local_event.position
		if countpoint == 0:
			startpoint = local_event.position
			stoppoint = Vector2(local_event.position.x, local_event.position.y+1)
		queue_redraw()
		var array = [startpoint,stoppoint]
		vectorArray.append(array)
		startpoint = stoppoint
		countpoint = 1
		countdown = 3
	if (event is InputEventScreenTouch) && (event.is_pressed()):
		pass # start touch which means start drag
	else:
		countdown -= 1
		if countdown ==0:
			countpoint = 0


