extends Timer

const weekdays = ['Sun.', 'Mon.', 'Tue.', 'Wed.', 'Thur.', 'Fri.', 'Sat.']
const seasons = ['Spring', 'Summer', 'Fall', 'Winter']
const am_pm = ["AM", "PM"]
const minute_intervals = ['00', '10', '20', '30', '40', '50']

export (int) var second = 21600
export (int) var minute = 0
export (int) var hour = 6
export (int) var day = 1
export (int) var month = 1
export (int) var year = 1

export (int) var hour_show = 6
export (String) var weekday = "Sun."
export (int) var weekday_counter = 0
export (String) var season = 'Spring'
export (String) var meridiem = "AM"
export (String) var minute_interval = '00'

var day_processed = true

func _ready():
	pass
	
func _on_TimeSystem_timeout():
	if hour == 6 and not day_processed:
		start_new_day()
		
	if hour == 5:
		day_processed = false
		
	second += 60 
	minute = (int(second) / 60) % 60 # Using modulo returns the number of mins
	hour = (int(second) / 3600 ) % 24
	meridiem = am_pm[hour / 12]
	minute_interval = minute_intervals[minute/10]
	hour_show = hour
	if hour > 12:
		hour_show -= 12
	if hour == 0:
		hour_show = 12
	
func start_new_day():
	second = 21600
	minute = 360
	hour = 6
	day += 1
	weekday
	day_processed = true
	# Current Month should end below
	if day == 29: 
		month += 1
		day = 1
		season = seasons[month - 1]
		# Current Year should end below
		if month == 5:
			year += 1
			month = 1
	
	weekday_counter = int(day) % 7 - 1
	weekday = weekdays[weekday_counter]


