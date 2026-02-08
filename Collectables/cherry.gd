extends Area2D

var picked := false   # prevents double trigger

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")

	await get_tree().create_timer(8.0).timeout
	if !picked:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and !picked:
		picked = true

		Game.Gold += 5
		Game.set_hp(Game.playerHP + 1)

		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()

		tween1.tween_property(self, "position", position - Vector2(0, 30), 0.4)
		tween2.tween_property(self, "modulate:a", 0, 0.3)

		tween1.tween_callback(queue_free)
