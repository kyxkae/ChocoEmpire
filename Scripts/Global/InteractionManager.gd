extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const BASE_TEXT: String = "[E] to "
var active_areas = []
var can_interact = true

signal interaction_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null:
		assert(false, "Player not found, check grouping and check if player exists in scene")

	print("Good news: Player found")
	DialogManager.started_dialog.connect(_hide_prompt)
	DialogManager.finished_dialog.connect(_show_prompt)
	interaction_finished.connect(_on_interact_finished)

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			active_areas.sort_custom(_sort_by_distance)
			_hide_prompt()
			print(active_areas[0].get_path())
			await active_areas[0].interact.call()

#region Area Register
func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
#endregion

func _process(_delta):
	if active_areas.size() > 0 && can_interact && !DialogManager.is_dialog_active:
		label.text = BASE_TEXT + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 50
		label.global_position.x -= label.size.x / 2
		_show_prompt()
	else:
		_hide_prompt()

func _sort_by_distance(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _on_interact_finished():
	can_interact = true

#region prompt handling
func _hide_prompt():
	label.hide()

func _show_prompt():
	label.show()
#endregion
