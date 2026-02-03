extends DialogEvent
class_name DialogMessage

@export var dialog_lines: Array[String]
@export var speaker_name: String = ""
@export var line_index = 0


func advance() -> bool:
	line_index += 1
	return line_index >= dialog_lines.size()
