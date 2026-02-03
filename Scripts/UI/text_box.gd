extends MarginContainer

@onready var timer = $LetterDiaplayTimer
@onready var dialog_text = $MarginContainer/VBoxContainer/dialog_text
@onready var speaker = $MarginContainer/VBoxContainer/Speaker

const MAX_WIDTH: int = 256
var text : String = ""
var npc_name: String = ""
var letter_index: int = 0
var letter_time: float = 0.03
var space_time: float = 0.06
var punctuation_time: float = 0.2

signal finished_displaying

func display_text(dialog_event: DialogEvent):
	text = dialog_event.dialog_lines[dialog_event.line_index]
	speaker.text = dialog_event.speaker_name
	dialog_text.text = text
	await resized
	custom_minimum_size.x =min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		dialog_text.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	dialog_text.text = ""
	_display_letter()
	
func _display_letter():
	dialog_text.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	match text[letter_index]:
		"!",".",",","?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
	


func _on_letter_diaplay_timer_timeout():
	_display_letter()
