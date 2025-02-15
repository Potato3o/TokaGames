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
	if GameType == "Trace":
		SetupTrace()
	elif GameType == "Drag":
		SetUpDrag()
	elif GameType == "Compare":
		SetupCompare()


#trace minigame functions
func SetupTrace():
	if cardColor == 1:
		Nums.remove_at(10)
	newNumber()
	cards = LevelType.instantiate()
	var firstcard = cards.get_child(cardColor).get_child(cardNumber).duplicate()
	firstcard.position = Vector2.ZERO
	add_child(firstcard)
	if cardNumber != 0 && cardColor == 2:
		return 
	Count = 1

func newCard():
	var card = cards.get_child(cardColor).get_child(cardNumber).duplicate()
	card.position = Vector2.ZERO
	if cardColor == 2 and cardNumber == 0:
		Count = 1
	add_child(card)

func Tracevictory(card):
	if cardColor != 2:
		Count = 2
	else:
		Count += 1
	if Count >= 2:
		vicNoise.play()
		timer.start()
		Count = 0 
		targetCard = card

#gets next card number
func newNumber():
	if random:
		randomize()
		var place = randi_range(0,Nums.size()-1)
		cardNumber = Nums[place]
		Nums.remove_at(place)
	else:
		cardNumber += 1

#Drag'n'Drop Minigame functions
func Dragvictory():
	Count += 1
	if Count >= 5:
		vicNoise.play()
	else:
		get_node("Click").play()

func SetUpDrag():
	#sets up the five random number values in Nums
	var Values = []
	if cardColor == 1 or subColor == 1:
		Nums.remove_at(0)
	for i in range(5):
		randomize()
		var num = randi_range(0,Nums.size()-1)
		Values.append(Nums[num])
		Nums.remove_at(num)
	#assigns numbers randomly to both sides
	var Moveables = get_node("Moveable").get_children()
	var Recivers = get_node("Recivers").get_children()
	var place
	for i in range(5):
		randomize()
		var thing = Values[randi_range(0,Values.size()-1)]
		place = randi_range(0,Moveables.size()-1)
		Moveables[place].value = thing
		Moveables.remove_at(place)
		randomize()
		place = randi_range(0,Recivers.size()-1)
		Recivers[place].value = thing
		Recivers.remove_at(place)
		Values.remove_at(Values.find(thing))
	#tells nodes to change sprite
	Moveables = get_node("Moveable").get_children()
	Recivers = get_node("Recivers").get_children()
	for i in range(5):
		Moveables[i].changeLook(cardColor)
		Recivers[i].changeLook(subColor)
	#set selected placeholder
	global.selected = self


#compare Minigame functions
func SetupCompare():
	#array of needed values
	var nums = {"min":0,"value1":0,"value2":0,"colors":["Blue","Yellow","Red"],"answer":0}
	#if any card is yellow, take away the value 0 as an option
	if cardColor == 1 or subColor == 1:
		nums["min"] = 1
	#set both random values
	randomize()
	nums["value1"] = randi_range(nums["min"],10)
	nums["value2"] = randi_range(nums["min"],10)
	#determine right answers
	if nums["value1"] > nums["value2"]:
		nums["answer"] = 1
	elif nums["value1"] < nums["value2"]:
		nums["answer"] = 0
	else:
		nums["answer"] = 2
	#set sprites and values
	get_node("Pos1").texture = load("res://Sprites/" + nums["colors"][cardColor] + "Cards/"+ nums["colors"][cardColor] + str(nums["value1"]) + ".png")
	get_node("Pos2").texture = load("res://Sprites/" + nums["colors"][subColor] + "Cards/"+ nums["colors"][subColor] + str(nums["value2"]) + ".png")
	get_node("AnswerButton").correct = nums["answer"]
	get_node("AnswerButton").scuffle()

func Comparevictory():
	Count += 1
	if Count == 5:
		get_tree().change_scene_to_file("res://MainScene.tscn")
	else:
		SetupCompare()


#on timer timeout(trace)
func _on_timer_timeout():
	targetCard.queue_free()
	totalCards += 1
	if (totalCards >= 11) or (cardColor == 1 && totalCards >= 10):
		get_tree().change_scene_to_file("res://MainScene.tscn")
		#complete level
	else:
		newNumber()
		newCard()

#on correct noise finish playing(Drag)
func _on_correct_finished():
	get_tree().change_scene_to_file("res://MainScene.tscn")
