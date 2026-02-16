extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimationPlayer
@onready var game_music = get_parent().get_node("GameMusic")

var current_anim := ""
var is_dead := false


func die():

	is_dead = true
	velocity = Vector2.ZERO

	# 🎵 Stop gameplay music
	if game_music:
		game_music.stop()
		game_music.seek(0.0)

	play_anim("Death")

	await anim.animation_finished
	await get_tree().create_timer(1.0).timeout

	queue_free()
	get_tree().change_scene_to_file("res://main.tscn")


func play_anim(animation: String):
	if current_anim != animation:
		current_anim = animation
		anim.play(animation)


func _physics_process(delta):

	if is_dead:
		return

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

	# Apply movement
	move_and_slide()

	# Animation logic
	if not is_on_floor():
		if velocity.y < 0:
			play_anim("Jump")
		else:
			play_anim("Fall")
	elif direction:
		play_anim("Run")
	else:
		play_anim("Idle")

	# 💀 Death check
	if Game.playerHP <= 0 and not is_dead:
		die()
