extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
# If you used a plain Sprite2D, just change the type above

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED

		# Flip the sprite depending on direction
		sprite.flip_h = direction < 0

		# Play run animation
		if sprite.animation != "RUN":
			sprite.play("RUN")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Stop run animation (optional: switch to idle)
		if sprite.animation != "IDLE":
			sprite.play("IDLE")

	move_and_slide()
