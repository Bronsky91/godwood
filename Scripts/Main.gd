extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Create_button_up():
	hide()
	get_node('../CharacterCreation').show()


func _on_View_button_up():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Exit_button_up():
	get_tree().quit()

