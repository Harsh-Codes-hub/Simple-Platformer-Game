extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED := 50.0
var chase := false
var is_dead := false

@onready var anim := $AnimatedSprite2D


func _ready() -> void:
	anim.play("Idle")


func _physics_process(delta: float) -> void:
	if is_dead:
		velocity.x = 0
		move_and_slide()
		return

	velocity.y += gravity * delta

	if chase:
		if anim.animation != "Death":
			anim.play("Jump")

		var player := $"../../player/player"
		var direction = (player.position - position).normalized()

		anim.flip_h = direction.x > 0
		velocity.x = direction.x * SPEED
	else:
		if anim.animation != "Death":
			anim.play("Idle")
		velocity.x = 0

	move_and_slide()


# --- Detection ---
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chase = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chase = false


# --- Head stomp ---
func _on_player_death_body_entered(body: Node2D) -> void:
	if is_dead:
		return
	if body.name != "player":
		return

	if body.global_position.y < global_position.y:
		Game.Gold += 5
		body.velocity.y = -250
		death()


# --- Side / bottom damage ---
func _on_player_collison_body_entered(body: Node2D) -> void:
	if is_dead:
		return
	if body.name == "player":
		Game.set_hp(Game.playerHP - 3)
		Game.Gold += 3
		death()


# --- Death ---
func death():
	if is_dead:
		return
	Utils.saveGame()
	is_dead = true
	chase = false

	$CollisionShape2D.set_deferred("disabled", true)

	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()
