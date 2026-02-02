class_name NPC_Base
extends Node2D
@onready var dialog_commponent: DialogCommponent = $DialogCommponent
@onready var sprite = $AnimatedSprite2D
@onready var interaction_area = $InteractionArea
@onready var label = $Label
var npc_name: String
var interaction_type: String
var dialog_type: DialogCommponent.DIALOG_TYPE
var threshold: float
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.action_name = dialog_commponent.interact_type
	npc_name = dialog_commponent.initializer_name 
	InteractionManager.interaction_finished.connect(_on_interact_finished)

	if interaction_area.collision.shape is CircleShape2D:
		threshold = interaction_area.collision.shape.radius
	else:
		assert(false, "this interaction only supports Cirleshape2D")

func _on_interact():
	if interaction_area.global_position.distance_to(global_position) < threshold:
		label.hide()
		print("Hidden labal")
		print(dialog_commponent.lines[0])
		DialogManager.start_dialog(global_position,npc_name, dialog_commponent.lines)
		sprite.flip_h = true
	else: 
		sprite.flip_h = false

func _on_interact_finished():
	label.show()
	print("Show labal")

func random_movement():
	pass
