extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
var player
var chase = false

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if (chase == true):
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Jump")
		player = $"../../player/player"
		var direction = (player.position - self.position).normalized()
		if (direction.x > 0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "player":
		chase = true

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chase = false


func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "player":
		death()


func _on_player_collison_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.health -= 3
		death()

func death():
		chase = false
		$AnimatedSprite2D.play("Death")
		await $AnimatedSprite2D.animation_finished
		self.queue_free()
