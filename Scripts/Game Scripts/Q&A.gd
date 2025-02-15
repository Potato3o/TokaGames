extends Control

var Value1 = 3
var max = 5
var Value2 = max - Value1
var order = 0
var Dot = true

var card

var check = true

func showEquation():
	$Equation.text = str(Value1) + " + " + str(Value2) + " = " + str(max)
	$Equation.visible = true
	$Delay.start()

func _on_line_edit_text_submitted(new_text):
	if (new_text == str(Value1)) and (order == 0) and check:
		order += 1
		check = false
		Value2 = max - Value1
		Next()
		return
	if (new_text == str(Value2)) and (order == 2):
		order += 1
		Next()
		return
	$LineEdit.text = ""
	

func Next():
	if order == 1:
		get_node("../Correct").play()
		$LineEdit.visible = false
		$Correct.visible = true
		$Delay.start()
	if order == 2:
		$Question.text = "How much more to make " + str(max) + "?"
		$LineEdit.text = ""
		$LineEdit.visible = true
		$Correct.visible = false
	if order == 3:
		if Dot:
			$Question.text = "Fill in the dots to make " + str(max)
			$LineEdit.visible = false
			card.drawable = true
		else:
			get_node("../Correct").play()
			showEquation()
			$LineEdit.visible = false
			$Correct.visible = true
	if order == 4:
		if Dot:
			card.queue_free()
		order = 0
		get_parent().SetUpComp(Value1 + 1, max)
		$Question.text = "what is the number on this card?"
		$LineEdit.text = ""
		$LineEdit.visible = true
		$Equation.visible = false
		$Correct.visible = false
		
	check = true

func _on_delay_timeout():
	order += 1
	Next()
