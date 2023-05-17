extends TouchScreenButton







func _on_pressed():
	$"./games menu".current = true
	$"../games menu".make_current()
