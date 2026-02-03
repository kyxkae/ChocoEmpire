class_name NPC_Base
extends Node2D
@onready var dialog_commponent: DialogCommponent = %DialogCommponent
@onready var sprite = $AnimatedSprite2D
@onready var interaction_area = $InteractionArea

@export var dialog_events: Array[DialogEvent]

var npc_name: String
var interaction_type: String
var threshold: float

func _ready():
	set_up_npc()
	

func _on_interact():
	if interaction_area.global_position.distance_to(global_position) < threshold:
		print("Hidden labal")
		print(dialog_commponent.lines[0])
		DialogManager.start_dialog(dialog_events)
		sprite.flip_h = true
	else: 
		sprite.flip_h = false


func random_movement():
	pass
	
func set_up_npc():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.action_name = dialog_commponent.interact_type
	npc_name = dialog_commponent.initializer_name 

	if interaction_area.collision.shape is CircleShape2D:
		threshold = interaction_area.collision.shape.radius
	else:
		assert(false, "this interaction only supports Cirleshape2D")
