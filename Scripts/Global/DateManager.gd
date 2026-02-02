extends Node

signal day_changed
signal year_changed

var current_day: int: get = get_current_day, set = set_current_day
var current_year: int: get = get_current_year,set = set_current_year

func get_current_day():
	return current_day

func set_current_day(value: int):
	if value > 1:
		pass
	else:
		if current_day < 0:
			current_day = 1
		elif current_day >= 300:
			current_day = 1
			current_year += 1
			year_changed.emit()
		else: 
			current_day += 1
			day_changed.emit()

func get_current_year():
	return current_year
	
func set_current_year(value: int):
	current_year = value
