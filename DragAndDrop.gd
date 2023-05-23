extends Node2D
var is_dragging = false
var touchpos = 0


# Called when the node enters the scene tree for the first time.
func _input(event):
	var local_event = make_input_local(event)
	if event is InputEventScreenTouch:
		if local_event.is_pressed():
			is_dragging = true
		else:
			is_dragging = false
	if is_dragging:
		touchpos = local_event.position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dragging and global.touched:
		global.selected.global_position = touchpos


func _on_area_2d_area_entered(area):
	pass
