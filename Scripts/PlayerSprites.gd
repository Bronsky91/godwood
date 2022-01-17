extends Node2D

var z_index_library: Dictionary

func _ready():
	z_index_library = load_json("res://Resources/JSON/z_index_player_library.json")
	#$AnimationPlayer.play("idle_front")
	#for sprite in $SpriteHolder.get_children():
		#sprite.vframes = 5
	# Load character state

func _process(delta):
	pass

func load_json(file_path: String) -> Dictionary:
	var file = File.new()
	file.open(file_path, File.READ)
	var text = file.get_as_text()
	return JSON.parse(text).result

func set_node_indices(direction):
	# Sort the sprites in proper draw order based on direction
	for sprite in $SpriteHolder.get_children():
		var new_sprite_index = z_index_library[sprite.name][direction]-1
		$SpriteHolder.move_child(sprite, new_sprite_index)
	# Resort if any are out of place from the first sorting
	for sprite in $SpriteHolder.get_children():
		var new_sprite_index = z_index_library[sprite.name][direction]-1
		if new_sprite_index != sprite.get_index():
			$SpriteHolder.move_child(sprite, new_sprite_index)

func _on_AnimationPlayer_animation_started(anim_name: String):
	var direction = anim_name.split("_")[1]
	set_node_indices(direction)
