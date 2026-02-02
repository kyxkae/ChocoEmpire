extends Node

var current_money : int: get = get_current_money, set = set_current_money
signal money_changed

func set_current_money(money_to_add: int):
	current_money += money_to_add
	money_changed.emit()

func get_current_money():
	return current_money
