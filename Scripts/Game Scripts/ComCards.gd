extends Node2D

var Filledin = []
var drawable = false
var QA
var isRed = false
var num
@onready var Dots = get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Dots:
		i.pressed.connect(_on_dot_pressed)
	Filledin.resize(get_child_count())
	Filledin.fill(false)

func SetCardUp(amount,cardcolor):
	num = amount
	
	
	
	if cardcolor == 2:
		isRed = true
	
	QA = get_node("../QA")
	for i in range(num):
		Filledin[i] = true
	queue_redraw()
		
	






func _draw():
	for i in range(Filledin.size()):
		if not Filledin[i]:
			draw_circle(Dots[i].position,33,Color.WHITE)
		else:
			draw_circle(Dots[i].position,33,Color.BLACK)
		



func randomNum(total):
	randomize()
	return randi_range(1,total)

# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_dot_pressed():
	if drawable:
		for i in Dots:
			var DotNum = int(i.name.substr(i.name.length()-1))
			if i.is_pressed() and (not Filledin[DotNum-1]):
				Filledin[DotNum-1] = true
				get_node("../Click").play()
				queue_redraw()
		
		#update red card to match amount of dots filled in
		if isRed:
			num = 0
			for i in Filledin:
				if i:
					num += 1
			self.texture = load("res://Sprites/RedCards/Red" + str(num) + ".png")
		
		if Filledin.find(false) <= -1:
			QA.get_node("Correct").visible = true
			get_node("../Correct").play()
			QA.showEquation()
				
