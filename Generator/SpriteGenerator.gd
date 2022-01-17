extends Node2D

const player_scene = preload("res://Scenes/Player.tscn")

func _ready():
	var player_array = g.load_dress_up_players()
	var test_sprite = player_array[0]
	var new_player = player_scene.instance()
	new_player.p_name = test_sprite.name
	g.load_player(new_player.get_node("PlayerSprites/SpriteHolder"), test_sprite.name)
	new_player.position = $Position2D.global_position
	$ViewportContainer/Viewport.add_child(new_player)

func _input(event):
	if event.is_action_released("hoe"):
		save_img()


func save_img():
	var image = $ViewportContainer/Viewport.get_texture().get_data()
	image.convert(Image.FORMAT_RGBA8)
	image.flip_y()
	image.save_png("C:/Users/bryan/Desktop/test_screenshot.png")
