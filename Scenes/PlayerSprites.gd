extends Node2D

var z_index_library: Dictionary

func _ready():
	z_index_library = load_json("res://Resources/JSON/z_index_player_library.json")

func _process(delta):
	pass

func load_json(file_path: String) -> Dictionary:
	var file = File.new()
	file.open(file_path, File.READ)
	var text = file.get_as_text()
	return JSON.parse(text).result

func set_z_indices(direction):
	for sprite in get_children():
		sprite.z_index = z_index_library[sprite][direction]

func _on_AnimationPlayer_animation_started(anim_name: String):
	var direction = anim_name.split("_")[1]
	set_z_indices(direction)
