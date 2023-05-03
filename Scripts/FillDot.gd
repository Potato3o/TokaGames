
extends TouchScreenButton

var dotColor = Color.WHITE
# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(makeVis)
	

func _draw():
	draw_circle(Vector2.ZERO,33,dotColor)


func makeVis():
	dotColor = Color.BLACK
	queue_redraw()
	
