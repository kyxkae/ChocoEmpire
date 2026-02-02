class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var speed:= 8.0
@export var gravity_multiplier := 4.6

# direction of movement setup
var direction: Vector2 = Vector2.ZERO

# for IDLE SETUP
enum Facing {UP, DOWN, LEFT, RIGHT, UP_RIGHT, DOWN_RIGHT, UP_LEFT, DOWN_LEFT}
var facing_direction: Facing = Facing.DOWN

func _set_idle_animation(dir: Facing) -> void:
	facing_direction = dir
	var anim_name: String = "idle_" + Facing.keys()[dir].to_lower()
	if sprite.animation != anim_name:
		sprite.play(anim_name)

func _set_interact_animation(dir: Facing) -> void:
	facing_direction = dir
	var anim_name: String = "interact_" + Facing.keys()[dir].to_lower()
	if sprite.animation != anim_name:
		sprite.play(anim_name)

func tick(_delta: float) -> void:
	if body == null:
		return
	
	body.velocity.x = direction.x * speed
	body.velocity.y = direction.y * speed
	set_animation()
	
	
	body.move_and_slide()

func set_animation():
	#region State machine
	# right
	if body.velocity.x > 0 && body.velocity.y == 0:
		sprite.flip_h = false
		sprite.play("walk_right")
		facing_direction = Facing.RIGHT
		
	# left
	elif body.velocity.x < 0 && body.velocity.y == 0:
		sprite.flip_h = true
		sprite.play("walk_right")
		facing_direction = Facing.RIGHT
	#down
	elif body.velocity.y > 0 && body.velocity.x == 0:
		sprite.play("walk_down")
		facing_direction = Facing.DOWN
	# up
	elif body.velocity.y < 0 && body.velocity.x == 0:
		sprite.play("walk_up")
		facing_direction = Facing.UP
	# down left
	elif body.velocity.y > 0 && body.velocity.x < 0:
		sprite.play("walk_down_right")
		sprite.flip_h = true
		facing_direction = Facing.DOWN_RIGHT
	# down right
	elif body.velocity.y > 0 && body.velocity.x > 0:
		sprite.flip_h = false
		sprite.play("walk_down_right")
		facing_direction = Facing.DOWN_RIGHT
	# up left
	elif body.velocity.y < 0 && body.velocity.x < 0:
		sprite.play("walk_up_right")
		sprite.flip_h = true
		facing_direction = Facing.UP_RIGHT
	# up right
	elif body.velocity.y < 0 && body.velocity.x > 0:
		sprite.flip_h = false
		sprite.play("walk_up_right")
		facing_direction = Facing.UP_RIGHT
	else:
		_set_idle_animation(facing_direction)
	#endregion
