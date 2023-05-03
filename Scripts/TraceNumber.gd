extends Sprite2D

var startpoint = Vector2.ZERO
var stoppoint = Vector2.ZERO
var count = 0
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _draw():
	draw_line(startpoint,stoppoint,Color.YELLOW,3)

func _input(event):
	if event is InputEventScreenDrag:
		print("drag")
		stoppoint = event.position 
		if count == 0:
			startpoint = event.position
			stoppoint = Vector2(event.position.x+1.0,event.position.y)
		queue_redraw()
		startpoint = event.position
		count += 1
		
		
