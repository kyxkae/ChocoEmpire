class_name NPC_Base
extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var interaction_area = $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")

@export var dialog_events: Array[DialogEvent]

var npc_name: String
var interaction_type: String
var threshold: float

func _ready():
	set_up_npc()
	

func _on_interact():
	if interaction_area.global_position.distance_to(global_position) < threshold:
		DialogManager.start_dialog(dialog_events)
		sprite.flip_h = true
	else: 
		sprite.flip_h = false


func random_movement():
	pass
	
func set_up_npc():
	interaction_area.interact = Callable(self, "_on_interact")

	if interaction_area.collision.shape is CircleShape2D:
		threshold = interaction_area.collision.shape.radius
	else:
		assert(false, "this interaction only supports Cirleshape2D")
