extends Control

# container holding the building buttons
@onready var buildingButtons : Node = get_node("BuildingButton")

# text displaying the food and metal resources
@onready var foodMetalText : Label = get_node("FoodMetalText")

# text showing our current turn
@onready var curTurnText : Label = get_node("TurnNumberText")

# game manager object in order to access those functions and values
@onready var gameManager : Node = get_node("/root/Game")

# called when a turn is over - resets the UI
func on_end_turn ():
	# updates the cur turn text and enable the building buttons
	curTurnText.text = "Turn: " + str(gameManager.curTurn)
	buildingButtons.visible = true


# updates the resource text to show the current values
func update_resource_text ():
	# set the food and metal text
	var foodMetal = ""

	# sets the text, e.g. "13 (+5)"
	foodMetal += str(gameManager.curFood) + " (" + ("+" if gameManager.foodPerTurn >= 0 else "") + str(gameManager.foodPerTurn) + ")"
	foodMetal += "\n"
	foodMetal += str(gameManager.curMetal) + " (" + ("+" if gameManager.metalPerTurn >= 0 else "") + str(gameManager.metalPerTurn) + ")"  
	foodMetal += "\n"
	foodMetal += str(gameManager.curEnergy) + " (" + ("+" if gameManager.energyPerTurn >= 0 else "") + str(gameManager.energyPerTurn) + ")"  
	
	foodMetalText.text = foodMetal


func _on_end_turn_button_pressed() -> void:
	gameManager.end_turn()


func _on_mine_button_pressed() -> void:
	buildingButtons.visible = false
	gameManager.on_select_building(1)


func _on_barn_button_pressed() -> void:
	buildingButtons.visible = false
	gameManager.on_select_building(2)


func _on_farm_button_pressed() -> void:
	buildingButtons.visible = false
	gameManager.on_select_building(3)
