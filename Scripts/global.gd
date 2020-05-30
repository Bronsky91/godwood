extends Node

func _ready():
	pass # Replace with function body.

func save_time(time: Dictionary) -> void:
	var f: File = File.new()
	f.open("user://time.save", File.READ)
	var json: JSONParseResult = JSON.parse(f.get_as_text())
	f.close()
	var data: Dictionary = json.result
	data = {
		"time": time
	}
	# Save
	f = File.new()
	f.open("user://time.save", File.WRITE)
	f.store_string(JSON.print(data, "  ", true))
	f.close()
	
func load_time() -> int:
	var save_time: File = File.new()
	var new_game = !save_time.file_exists("user://time.save")
	if new_game:
		return 3600 * 6 # 6am
	save_time.open("user://time.save", File.READ)
	var text: String = save_time.get_as_text()
	var data: Dictionary = parse_json(text)
	save_time.close()
	return data.time
	
func files_in_dir(path: String, keyword: String = "") -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif keyword != "" and file.find(keyword) == -1:
			continue
		elif not file.begins_with(".") and not file.ends_with(".import"):
			files.append(file)
	dir.list_dir_end()
	return files
	
func save_character(state: Dictionary, slot: String):
	# TODO: pass in state dictionary of all the character deets
	# TODO: If there is no current character slot, make a new one and save
	# TODO: Include farm/world state
	var f: File = File.new()
	f.open("user://character-"+slot+".save", File.READ)
	var json: JSONParseResult = JSON.parse(f.get_as_text())
	f.close()
	var data: Dictionary = json.result
	data = {
	#	character: state
	}
	# Save
	f = File.new()
	f.open("user://character-"+slot+".save", File.WRITE)
	f.store_string(JSON.print(data, "  ", true))
	f.close()
	
func load_character(slot) -> Dictionary:
	var character_slot: File = File.new()
	character_slot.open("user://character-"+slot+".save", File.READ)
	var text: String = character_slot.get_as_text()
	var data: Dictionary = parse_json(text)
	character_slot.close()
	return data.character
