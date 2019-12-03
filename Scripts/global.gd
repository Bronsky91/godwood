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