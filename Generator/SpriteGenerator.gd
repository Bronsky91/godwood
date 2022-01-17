extends Node2D

const player_sprites_scene = preload("res://Scenes/PlayerSprites.tscn")

func _ready():
	pass

func save_img():
	var image = $ViewportContainer/Viewport.get_texture().get_data()
	image.convert(Image.FORMAT_RGBA8)
	image.flip_y()
	image.save_png("C:/Users/bryan/Desktop/test_screenshot.png")
