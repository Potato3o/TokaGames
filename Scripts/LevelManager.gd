extends Node

@export var LevelType = preload("res://Scenes/Cards/TraceCards.tscn")
#temperoary variable, for now it holds the color card we want
#0 = blue, 1 = yellow, 2 = red
@export var cardColor = 0
@export var cardNumber = 4
#the cards scene
var cards

# loads cards and places the first one
func _ready():
	if cardColor == 1 && cardNumber != 0:
		cardNumber -= 1
		
	cards = LevelType.instantiate()
	var firstcard = cards.get_child(cardColor).get_child(cardNumber).duplicate()
	firstcard.position = Vector2.ZERO
	add_child(firstcard)

func newCard():
	var card = cards.get_child(cardColor).get_child(cardNumber).duplicate()
	card.position = Vector2.ZERO
	add_child(card)


