extends Node2D

const player_scene = preload("res://Scenes/Player.tscn")

onready var farm = get_node("Navigation2D/YSort/Farm")
onready var ysort = get_node("Navigation2D/YSort")

func _ready():
	var new_player = player_scene.instance()
	new_player.position = farm.get_node("Positions/Position2D").global_position
	ysort.add_child(new_player)

func _process(delta):
	pass

func _on_Leave_button_up():
	get_tree().change_scene("res://Scenes/Menu.tscn")
