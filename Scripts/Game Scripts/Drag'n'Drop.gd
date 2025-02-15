extends TouchScreenButton

#variables to check if a card is selected or avalible 
var selected = false
var ava = false

#card position variables
var pos = global_position
var OGpos = global_position

#card number value
@export var value = 0

#is the card dragable
@export var moveable = true

#game manager
@onready var manager = get_node("/root/Node2D")

func changeLook(color):
	#changes sprite based on given card color and its current value
	if color == 0:
		texture_normal = load("res://Sprites/BlueCards/Blue" + str(value) + ".png")
	elif color == 1:
		texture_normal = load("res://Sprites/YellowCards/Yellow" + str(value) + ".png")
	elif color == 2:
		texture_normal = load("res://Sprites/RedCards/Red" + str(value) + ".png")


func _input(event):
	#on input drag, set new card position
	var local_event = make_input_local(event)
	if event is InputEventScreenDrag and moveable:
		pos = to_global(local_event.position) + Vector2(-75,-100)


func _physics_process(delta):
	#if the current card is selected, move to position 
	if selected:
		global_position = lerp(global_position,pos,25 * delta)

#player selcting a card 
func _on_pressed():
	#if the card can be dragged, select card when pressed
	if moveable:
		selected = true
		global.selected = self
		

# when player lets go of the card
func _on_released():
	if moveable:
		#diselect card and move back to orginal position
		selected = false
		pos = OGpos
		animate()
	if !moveable:
		#start delay timer
		get_node("Delay").start()
	
#makes a tween animation of card moving back to OG position
func animate():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",OGpos,0.2)
	tween.play()




#after delay, check for correctness
func _on_delay_timeout():
	#if the selected card is eligable 
	if global.selected != get_parent().get_parent():
		#had the draggable card been relased 
		if !global.selected.selected:
			#do they match values
			if global.selected.value == value:
				#delete both cards and reset selected value 
				global.selected.queue_free()
				global.selected = get_parent().get_parent()
				manager.Dragvictory()
				queue_free()
