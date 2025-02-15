extends TouchScreenButton

#does button lead to a level or game
@export var IsLevel = false

#what camera the button will lead to 
@export var newCam = Camera2D.new()

#if button leads to level, these are level details 
#e stands for null
#0 = blue, 1 = yellow, 2 = red
@export var LevelFacts = {"GameType":"Trace","CardDeck":"e","Color":0,"Color2":-1,"Random":false}

# Called when the node enters the scene tree for the first time.
func _ready():
	if IsLevel:
		self.pressed.connect(MakeLevel)
	else:
		self.pressed.connect(SwitchMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func MakeLevel():
	global.LevelDetails = LevelFacts
	if LevelFacts["GameType"] == "Trace":
		get_tree().change_scene_to_file("res://Scenes/LevelTempletes/Trace.tscn")
	elif LevelFacts["GameType"] == "Drag":
		get_tree().change_scene_to_file("res://Scenes/LevelTempletes/Drag'n'Drop.tscn")
	elif LevelFacts["GameType"] == "Compare":
		get_tree().change_scene_to_file("res://Scenes/LevelTempletes/Compare.tscn")
	elif LevelFacts["GameType"] == "Comp":
		get_tree().change_scene_to_file("res://Scenes/LevelTempletes/Composition.tscn")

func SwitchMenu():
	newCam.enabled = true
	newCam.make_current()
