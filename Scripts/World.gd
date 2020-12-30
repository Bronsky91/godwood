extends Node2D

const player_scene = preload("res://Scenes/Player.tscn")
const name_item_scene = preload("res://Scenes/CharacterListItem.tscn")

onready var farm = get_node("Navigation2D/YSort/Farm")
onready var ysort = get_node("Navigation2D/YSort")

var player_array: Array

func _ready():
	player_array = g.load_dress_up_players()
	for player in player_array:	
		var new_player = player_scene.instance()
		new_player.p_name = player.name
		g.load_player(new_player.get_node("PlayerSprites/SpriteHolder"), player.name)
		new_player.position = farm.get_node("Positions/Position2D").global_position
		ysort.add_child(new_player)
		
		var new_list_item = name_item_scene.instance()
		new_list_item.get_node("Label").text = player.name
		new_list_item.connect('mouse_entered', self, '_on_Item_entered', [player])
		new_list_item.connect('mouse_exited', self, '_on_Item_exited', [player])
		new_list_item.get_node("Button").connect('button_up', self, '_on_Bye_button_up', [player.name, new_list_item])
		$UI/CharacterNames.add_child(new_list_item)


func _process(delta):
	pass

func _on_Item_entered(p_name):
	print('entered')
	
func _on_Item_exited(p_name):
	print('exited')

func _on_Leave_button_up():
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_Bye_button_up(p_name, list_item):
	g.remove_character_by_name(player_array, p_name)
	remove_player_from_scene(p_name)
	list_item.queue_free()

func remove_player_from_scene(p_name):
	for node in ysort.get_children():
		if "Player" in node.name and node.p_name == p_name:
			node.queue_free()
