extends Node

class Building:
	
	# building type
	var type : int
	
	# building texture
	var iconTexture : Texture
	
	# resource the building produces
	var prodResource : int = 0
	var prodResourceAmount : int
	
	# resource the building needs to be maintained
	var upkeepResource : int = 0
	var upkeepResourceAmount : int
	
	func _init (type, iconTexture, prodResource, prodResourceAmount, upkeepResource, upkeepResourceAmount):
		self.type = type
		self.iconTexture = iconTexture
		self.prodResource = prodResource
		self.prodResourceAmount = prodResourceAmount
		self.upkeepResource = upkeepResource
		self.upkeepResourceAmount = upkeepResourceAmount

## Building Types
# Base = 0, Structure08
# Mine = 1, Structure20
# Greenhouse = 2, Structure19
# Solar Panel = 3, Structure21

## Resources
# None = 0
# Food = 1
# Metal = 2
# Energy = 4

var base = Building.new(0, preload("res://Assets/kenney_medieval-rts/PNG/Default size/Structure/medievalStructure_08.png"), 0, 0, 0, 0)
var mine = Building.new(1, preload("res://Assets/kenney_medieval-rts/PNG/Default size/Structure/medievalStructure_20.png"), 2, 1, 4, 1)
var greenhouse = Building.new(2, preload("res://Assets/kenney_medieval-rts/PNG/Default size/Structure/medievalStructure_19.png"), 1, 1, 0, 0)
var solarpanel = Building.new(3, preload("res://Assets/kenney_medieval-rts/PNG/Default size/Structure/medievalStructure_21.png"), 4, 1, 0, 0)
