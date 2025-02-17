extends Node2D

var Dots = []
var count = 0
var Done = false

@onready var Click = get_node("/root/Node2D/Click")

# Called when the node enters the scene tree for the first time.
func _ready():
	Dots.resize(self.get_child_count())
	Dots.fill(false)
	for i in self.get_children():
		i.pressed.connect(makeVis)
	

func _draw():
	for i in range(Dots.size()):
		if Dots[i]:
			draw_circle(self.get_child(i).position,33,Color.BLACK)
		else:
			draw_circle(self.get_child(i).position,33,Color.WHITE)



func makeVis():
	for i in range(self.get_child_count()):
		var child = self.get_child(i)
		if child.is_pressed() && (Dots[i] == false):
			Dots[i] = true
			count += 1
			Click.play()
	if count >= self.get_child_count() && !Done:
		Done = true
		get_node("/root/Node2D").Tracevictory(self)
	queue_redraw()
	
