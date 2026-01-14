extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimationPlayer
var current_anim := ""

func play_anim(name: String):
	if current_anim != name:
		current_anim = name
		anim.play(name)

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# APPLY MOVEMENT FIRST
	move_and_slide()

	# ✅ ANIMATION LOGIC AFTER MOVEMENT
	if not is_on_floor():
		if velocity.y < 0:
			play_anim("Jump")
		else:
			play_anim("Fall")
	elif direction:
		play_anim("Run")
	else:
		play_anim("Idle")
