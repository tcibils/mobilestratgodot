extends Area2D


# is this the starting tile?
# a Base building will be placed here at the start of the game
@export var startTile:bool = false

# do we have a building on this tile?
var hasBuilding:bool = false

# can we place a building on this tile?
var canPlaceBuilding:bool = false

# components
@onready var highlight := get_node("Highlight")
@onready var buildingIcon := get_node("BuildingIcon")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# add the tile to the "Tiles" group when the node is initialized
	add_to_group("Tiles")


# turns on or off the green highlight
func toggle_highlight (toggle):
	highlight.visible = toggle
	canPlaceBuilding = toggle

# called when a building is placed on the tile
# sets the tile's building texture to display it
func place_building (buildingTexture):
	hasBuilding = true
	buildingIcon.texture = buildingTexture
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_Tile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# did we click on this tile with our mouse?
	if event is InputEventMouseButton and event.pressed:
		var gameManager = get_node("/root/Game")
		# if we can place a building down on this tile, then do so
		if gameManager.currentlyPlacingBuilding and canPlaceBuilding:
			gameManager.place_building(self)
			
