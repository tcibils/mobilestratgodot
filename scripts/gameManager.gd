extends Node2D


# current amount of each resource we have
var curFood : int = 0
var curMetal : int = 0
var curEnergy : int = 0


# amount of each resource we get each turn
var foodPerTurn : int = 0
var metalPerTurn : int = 0
var energyPerTurn : int = 0
var curTurn : int = 1


# are we currently placing down a building?
var currentlyPlacingBuilding := false

# type of building we're currently placing
var buildingToPlace : int = 0

# components
@onready var map : Node = get_node("Tiles")
@onready var ui : Node = get_node("UI")
 
# called when we've selected a building to place
func on_select_building (buildingType):
	currentlyPlacingBuilding = true
	buildingToPlace = buildingType
	# highlight the tiles we can place a building on
	map.highlight_available_tiles()

# adds an amount to a certain resource per turn
func add_to_resource_per_turn (resource, amount):
	# resource 0 means none, so return
	if resource == 0:
		return
	elif resource == 1:
		foodPerTurn += amount
	elif resource == 2:
		metalPerTurn += amount
	elif resource == 4:
		energyPerTurn += amount

# called when we place a building down on the grid
# resources per turn are added on a global variable level, without link to the building itself
# if it gets destroyed, the quantity of resource per turn would not go down.
func place_building (tileToPlaceOn):
	currentlyPlacingBuilding = false
	var texture : Texture
	
	# are we placing down a Mine?
	if buildingToPlace == 1:
		texture = BuildingData.mine.iconTexture
		add_to_resource_per_turn(BuildingData.mine.prodResource, BuildingData.mine.prodResourceAmount)
		add_to_resource_per_turn(BuildingData.mine.upkeepResource, -BuildingData.mine.upkeepResourceAmount)
		
	# are we placing down a Greenhouse?
	if buildingToPlace == 2:
		texture = BuildingData.greenhouse.iconTexture
		add_to_resource_per_turn(BuildingData.greenhouse.prodResource, BuildingData.greenhouse.prodResourceAmount)
		add_to_resource_per_turn(BuildingData.greenhouse.upkeepResource, -BuildingData.greenhouse.upkeepResourceAmount)
		
	# are we placing down a Solar Panel?
	if buildingToPlace == 3:
		texture = BuildingData.solarpanel.iconTexture
		add_to_resource_per_turn(BuildingData.solarpanel.prodResource, BuildingData.solarpanel.prodResourceAmount)
		add_to_resource_per_turn(BuildingData.solarpanel.upkeepResource, -BuildingData.solarpanel.upkeepResourceAmount)
		
	# place the building on the map
	map.place_building(tileToPlaceOn, texture)
	
	# update the UI to show changes immediately
	ui.update_resource_text()

# called when the player ends the turn
func end_turn ():
	# update our current resource amounts
	curFood += foodPerTurn
	curMetal += metalPerTurn
	curEnergy += energyPerTurn
	# increase current turn
	curTurn += 1
	# update the UI
	ui.update_resource_text()
	ui.on_end_turn()

func _ready ():
	
	var url = "https://www.strava.com/api/v3/athlete"
	
	# Replace ABCDEF by the "Request token" available here: https://www.strava.com/settings/api
	var headers = ["Authorization: Bearer "]
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_GET)
	$HTTPRequest.request_completed.connect(_on_request_completed)
	
	# updates the UI when the game starts
	ui.update_resource_text()
	ui.on_end_turn()

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json["firstname"])
	print(json["lastname"])
