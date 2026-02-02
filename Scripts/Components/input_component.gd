class_name InputComponent extends Node
var move_dir: Vector2 = Vector2.ZERO

func update() -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
