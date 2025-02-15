extends Node

var GameType = global.LevelDetails["GameType"]
var LevelType = global.LevelDetails["CardDeck"]
#holds the color card we want
#0 = blue, 1 = yellow, 2 = red
var cardColor = global.LevelDetails["Color"]
var subColor = global.LevelDetails["Color2"]
var cardNumber = -1

#the total amoumt of cards solved
var totalCards = 0

#is card order random
var random = global.LevelDetails["Random"]
#if order is random, which numbers are still avalibale if needed.
var Nums = [0,1,2,3,4,5,6,7,8,9,10]

#victory noise node and timer node
@onready var vicNoise = get_node("Correct")
@onready var timer = get_node("Timer")

#the cards scene(for trace)
var cards
var targetCard

#a variable to check if mutiple contidions have been met. 
var Count = 0

# loads cards and places the first one
func _ready():
	if LevelType != "e":
		LevelType = load(LevelType)
		cards = LevelType.instantiate()
	if GameType == "Comp":
		if random:
			SetUpComp(0,10)
		else:
			SetUpComp(0, 5)

func randNum(max):
	randomize()
	return randi_range(0,max)


func SetUpComp(num, max):
	if num > max:
		get_tree().change_scene_to_file("res://MainScene.tscn")
		return
	
	var QA = $QA
	var pos = $Pos1.position
	
	var newCard
	
	#if random is true, max = 10
	QA.max = max
	
	if cardColor == 0:
		get_node("Pos1").texture = load("res://Sprites/BlueCards/Blue" + str(num) + ".png")
		QA.Dot = false
	else:
		#gets new card by taking card color, than getting the number via max, as max is 5 or 10, so position will be 0 or 1
		newCard = cards.get_child(cardColor - 1).get_child((max/5) - 1).duplicate()
		newCard.position = pos
		
		if cardColor == 2:
			newCard.texture = load("res://Sprites/RedCards/Red" + str(num) + ".png")
		
		add_child(newCard)
		QA.card = newCard
		newCard.SetCardUp(num,cardColor)
	
	if num == max:
		QA.Dot = false
	
	QA.Value1 = num
	
