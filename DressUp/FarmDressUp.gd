extends Node2D

onready var available_positions = get_node("Positions").get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func free_position(pos):
	if pos:
		available_positions.append(pos)


func take_position(pos):
	available_positions.erase(pos)
	return pos
