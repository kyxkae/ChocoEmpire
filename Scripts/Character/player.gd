class_name PlayerClass extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent

func _ready():
	Global.Player = self

func _physics_process(delta):
	# READ CONTROLS
	input_component.update()
	movement_component.direction = input_component.move_dir
	movement_component.tick(delta)
