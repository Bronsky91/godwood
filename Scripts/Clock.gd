extends Timer

var time: int setget set_time, get_time

func _ready():
	set_time(g.load_time())

func _process(delta):
	pass

func _on_Clock_timeout():
	add_time(1)
	update_ui()

func add_time(value) -> void:
	var new_time: int = value + time
	set_time(new_time)

func set_time(new_time) -> void:
	time = new_time
	
func get_time() -> int:
	return time
	
func get_time_formatted(seconds) -> String:
	var days:int = seconds / 86400
	seconds %= 86400
	var hour: int = seconds / 3600
	var hourShow: int = hour
	if hour > 12:
		hourShow -= 12
	if hour == 0:
		hourShow = 12
	var meridiem: String = 'am'
	if hour >= 12:
		meridiem = 'pm'
	seconds %= 3600
	var minutes:int  = seconds / 60
	var formatted_time: String = "%d %02d:%02d %s" % [days, hourShow, minutes, meridiem]
	return formatted_time
	
func update_ui() -> void:
	get_parent().get_node("Label").text = get_time_formatted(get_time())