extends Timer

var time: int setget set_time, get_time

func _ready():
	set_time(g.load_time())

func _process(delta):
	pass

func _on_Clock_timeout():
	add_time(1)
	update_ui()
	var current_time = get_time() % 86400
	if current_time / 3600 == 3: # Time is 3am
		new_day()

func add_time(value: int) -> void:
	var new_time: int = value + time 
	set_time(new_time)

func set_time(new_time: int) -> void:
	time = new_time
	
func get_time() -> int:
	return time
	
func get_time_formatted(seconds: int) -> String:
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
	
func new_day() -> void:
	var seconds = get_time()
	var current_hour = seconds / 3600
	seconds %= 3600
	var minutes:int  = seconds / 60
	if current_hour >= 6:
		add_time(((24-(current_hour-6)) * 3600) - minutes * 60)
	else:
		add_time(((6-current_hour) * 3600) - minutes * 60)
	#seconds %= 3600
	#var current_min = seconds / 60
	#var six_am = (24-(current_hour-6)) * 3600
	#print(six_am)
	#var min_difference = current_min)
	#print(sixty_min)
	#set_time(get_time() + six_am - current_min)
	
func update_ui() -> void:
	get_parent().get_node("Label").text = get_time_formatted(get_time())