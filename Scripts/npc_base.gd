extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var interaction_area = $InteractionArea
@export var interact_type: String = "Talk"
@export var lines : Array[String] = ["No Dialog set", "Test", "Test2"]
var threshold: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	interaction_area.action_name = interact_type
	if interaction_area.collision.shape is CircleShape2D:
		threshold = interaction_area.collision.shape.radius
	else:
		assert(false, "this interaction only supports Cirleshape2D")

func _on_interact():
	if interaction_area.global_position.distance_to(global_position) < threshold:
		print(lines[0])
		DialogManager.start_dialog(global_position, lines)
		sprite.flip_h = true
	else: 
		sprite.flip_h = false
