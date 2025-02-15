extends TouchScreenButton

#answer is player response, coorect is the right answer
#0 = less then, 1 = greater then, 2 = equal to
var answer = 1
var correct = 0

#sign states and corrospoding Rect2 value
var states = ["less","great","equal"]
var regions = {"less":[Rect2(607,219,176,180),"is LESS than"],"great":[Rect2(402,219,176,180),"is GREATER than"],"equal":[Rect2(173,258,143,118),"is EQUAL to"]}
var current

var done = false

#text and symbol nodes
@onready var label = get_node("Label")
@onready var symbol = get_node("Symbol")

func scuffle():
	#sets random begaining answer
	randomize()
	answer = randi_range(0,2)
	current = states[answer]
	label.text = regions[current][1]
	symbol.texture.region = regions[current][0]
	done = false

#answer button pressed
func _on_pressed():
	if done:
		return
	if answer == 2:
		answer = 0
	else:
		answer += 1
	current = states[answer]
	label.text = regions[current][1]
	symbol.texture.region = regions[current][0]




func _on_submit_button_pressed():
	if done:
		return
	if answer == correct:
		get_node("../Correct").play()
		done = true
	else:
		get_node("../Wrong").play()


func _on_correct_finished():
	get_parent().Comparevictory()
