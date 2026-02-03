extends Node
@onready var text_box_scene = preload("uid://6ltdngpbyder")
@onready var quest_box_scene = preload("uid://dpbxhkrpr442o")

var events: Array[DialogEvent]
var current_event_index = 0
var is_dialog_active = false
var can_advance_event = false

var dialog_box

signal started_dialog
signal finished_dialog


func start_dialog(new_events: Array[DialogEvent]):
	if is_dialog_active:
		return
	events = new_events
	is_dialog_active = false
	current_event_index = 0
	process_event()
	
func process_event():
	var current_event:DialogEvent = events[current_event_index]
	if current_event is DialogMessage:
		_show_text_box(current_event)
	elif current_event is DialogQuest:
		_show_quest_window(current_event)
	is_dialog_active = true
	started_dialog.emit()

func _show_text_box(current_event:DialogMessage):
	print("current event: %s, current line: %s)" % [current_event_index, current_event.line_index])
	dialog_box = text_box_scene.instantiate()
	dialog_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(dialog_box)
	dialog_box.display_text(current_event)
	can_advance_event = false

func _show_quest_window(current_event:DialogQuest):
	dialog_box = quest_box_scene.instantiate()
	dialog_box.response_given.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = current_event.dialog_box_position
	dialog_box.display_quest(current_event)
	can_advance_event = false
	
func _on_text_box_finished_displaying():
	can_advance_event = true

func _unhandled_input(event):
	if(
		event.is_action_pressed("advance_dialog") &&
		is_dialog_active && can_advance_event
	):
		var current_event:DialogEvent = events[current_event_index]
		var complete = current_event.advance()
		if complete:
			current_event_index += 1
		dialog_box.queue_free()
		
		if current_event_index >= current_event.dialog_lines.size():
			end_dialog()
		else:
			process_event()
			
func end_dialog():
	is_dialog_active = false
	current_event_index = 0
	finished_dialog.emit()
	InteractionManager.interaction_finished.emit()
	return
