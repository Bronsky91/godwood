extends Node2D

var z_index_library: Dictionary

func _ready():
	z_index_library = load_json("res://Resources/JSON/z_index_player_library.json")
	$AnimationPlayer.play("idle_front")
	# Load character state

func _process(delta):
	pass

func load_json(file_path: String) -> Dictionary:
	var file = File.new()
	file.open(file_path, File.READ)
	var text = file.get_as_text()
	return JSON.parse(text).result

func set_z_indices(direction):
	for sprite in $SpriteHolder.get_children():
		if sprite.name == "AnimationPlayer":
			continue
		print(sprite.name)
		print(sprite.get_index())
		print(z_index_library[sprite.name][direction]-1)
		$SpriteHolder.move_child(sprite, z_index_library[sprite.name][direction]-1)
		print(sprite.get_index())

func _on_AnimationPlayer_animation_started(anim_name: String):
	var direction = anim_name.split("_")[1]
	set_z_indices(direction)
	set_z_indices(direction)
