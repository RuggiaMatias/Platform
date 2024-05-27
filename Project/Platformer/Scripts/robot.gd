extends CharacterBody2D

# Speed form jumping and walking.
const SPEED = 150.0
const JUMP_VELOCITY = -333.0
@onready var screen_size = get_viewport_rect().size
# Character gravity
var gravity = 960
var can_double_jump = false

func _physics_process(delta):
	screen_wrap()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle doublejump.
	if is_on_floor():
		can_double_jump = true
		$AnimatedSprite2D/Marker2D/AnimatedSprite2D.stop()
	if not is_on_floor() and can_double_jump and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D/Marker2D/AnimatedSprite2D.play()
		$DoubleJump.play(0.5) # Plays boosting sound.
		can_double_jump = false
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Flip the sprite
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	# Play animations
	if is_on_floor():
		if direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("air")
	move_and_slide()
	
# Wrap character athe both sides of the screen
func screen_wrap():
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
