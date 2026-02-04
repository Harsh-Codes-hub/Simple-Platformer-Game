extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("Idle");

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Game.Gold += 5
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween1.tween_property(self, "position", position - Vector2(0, 30), 0.4)
		tween2.tween_property(self, "modulate:a", 0, 0.3)
		tween1.tween_callback(queue_free)
