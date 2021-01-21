extends Node2D

onready var character_create = get_node('../CharacterCreation')


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Create_button_up():
	character_create.create_random_character()
	character_create.get_node('TabContainer/Character/NameLabel/Name').text = ""
	hide()
	get_node('../CharacterCreation').show()


func _on_View_button_up():
	get_tree().change_scene("res://DressUp/WorldDressUp.tscn")


func _on_Exit_button_up():
	get_tree().quit()

