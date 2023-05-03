extends TouchScreenButton

@onready var timer = get_node("WaitTime") 
var selected = null
#is the player dragging?
var isDrag = false

func _process(delta):
	if isDrag:
		pass

func _input(event):
	#if event is InputEventScreenDrag and isDrag:
		#self.position = event.position
		#print(str(self.position) + "p")
		#print(str(event.position) + "e")
	if event is InputEventScreenTouch:
		print(event.position)
#timer to check if dragging or clicking 
func _on_wait_time_timeout():
	isDrag = true
	self.scale = Vector2(1.2,1.2)

#player selcting a card 
func _on_pressed():
	timer.start()
	print("hello touch")

# when player lets go of the card
func _on_released():
	timer.stop()
	if isDrag:
		self.scale = Vector2(1,1)
		#drop a dragged card
	elif !isDrag:
		pass
		#select card
	isDrag = false
	
