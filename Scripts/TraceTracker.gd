extends Node2D

#number of children
var max = 0

#how many buttons have been pressed, and what their pressed state is
var count = 0
var checkBox = []


#the point previous point and current point of the line segment 
var startpoint = Vector2.ZERO
var stoppoint = Vector2.ZERO
var countpoint = 0

#redraws these vectors 
var vectorArray = []

var hoffset = -600
var voffset = -600
var vscale = 1

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
	countpoint = 0


#when a trace button is pressed
func tracepressed():
	for i in range(self.get_child_count()):
		var child = self.get_child(i)
		if child.is_pressed() && (checkBox[i] == false):
			count += 1
			checkBox[i] = true
	if count >= max:
		get_parent().get_parent().cardNumber += 1
		get_parent().get_parent().newCard()
		queue_free()

func _draw():
	for i in vectorArray:
		draw_line((i[0] + Vector2(hoffset,voffset)) * Vector2(vscale,vscale),(i[1] + Vector2(hoffset,voffset))*Vector2(vscale,vscale),Color.YELLOW,10)

var differences = [] 

func _input(event):
	if event is InputEventScreenDrag:
		stoppoint = to_local(event.position)
		if countpoint == 0:
			startpoint = event.position
			stoppoint = event.position
		queue_redraw()
		var array = [startpoint,stoppoint]
		print("Reported: " + str(array[0].y))
		print("Actual  : " + str(get_viewport().get_mouse_position().y))
		differences.append(array[1].y-get_viewport().get_mouse_position().y)
		vectorArray.append(array)
		startpoint = event.position
		countpoint += 1
		if countpoint >= 100:
			print(differences)
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass # start touch which means start drag
		else:
			countpoint = 0
		
