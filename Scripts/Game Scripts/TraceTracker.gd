extends Node2D


var Done = false

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
var buttonArray = []

#should the player be able to draw right now?
var drawable = true
var pressNum = 0

#sounds
@onready var Marker = get_node("../../Marker")

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
		i.connect("released",EnableDraw)

#resets all arrays and counts
func clearOut():
	if !Done:
		vectorArray.clear()
		buttonArray.clear()
		checkBox.fill(false)
		count = 0
		countpoint = 0
		drawable = false
		pressNum += 1
		queue_redraw()

func EnableDraw():
	if !Done:
		pressNum -= 1
		if pressNum <= 0:
			drawable = true

#when a trace button is pressed
func tracepressed():
	for i in range(self.get_child_count()):
		var child = self.get_child(i)
		if child.is_pressed() && (checkBox[i] == false):
			count += 1
			checkBox[i] = true
			buttonArray.append(child.position)
	if count >= max && !Done:
		Done = true
		drawable = false
		Marker.stop()
		get_node("/root/Node2D").Tracevictory(get_parent())
		if get_node("/root/Node2D").cardColor != 2:
			queue_free()

func _draw():
	for v in buttonArray:
		draw_circle(v,10,Color.RED)
	for i in vectorArray:
		draw_line(i[0],i[1],Color.YELLOW,10)
	


func _input(event):
	if (event is InputEventScreenDrag) and (drawable):
		var local_event = make_input_local(event)
		stoppoint = local_event.position
		if countpoint == 0:
			startpoint = local_event.position
			stoppoint = Vector2(local_event.position.x,local_event.position.y+1)
		queue_redraw()
		var array = [startpoint,stoppoint]
		vectorArray.append(array)
		startpoint = stoppoint 
		countpoint = 1
		if !Marker.playing:
			Marker.play()
	if event is InputEventScreenTouch:
		if event.is_pressed() and !Done:
			if drawable and Marker.playing == false:
				Marker.play(1)
			elif !drawable:
				Marker.stop()
			pass # start touch which means start drag
		elif event.is_pressed() == false:
			countpoint = 0
			if Marker.playing:
				Marker.stop()
		


func _on_anti_draw_pressed():
	drawable = false
	Marker.stop()


func _on_anti_draw_released():
	if !Done:
		drawable = true
