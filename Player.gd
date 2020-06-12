extends KinematicBody2D

export var MAX_SPEED = 80  # How fast the player will move
export var ACCELERATION = 400
export var FRICTION = 400

var player

onready var anim = $AnimationPlayer
var velocity = Vector2.ZERO  # The player's movement vector.

# warning-ignore:unused_argument
func _physics_process(delta):
# Called every frame. 'delta' is the elapsed time since the previous frame.

	player = get_name()
	var input_vector=Vector2.ZERO
	
	input_vector.x = Input.get_action_strength(player+"_ui_right") - Input.get_action_strength(player+"_ui_left")
	input_vector.y = Input.get_action_strength(player+"_ui_down") - Input.get_action_strength(player+"_ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	var collision_info = move_and_collide(velocity * delta)

