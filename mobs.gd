extends Node2D

var frog = preload("res://frog/frog.tscn")


func _on_timer_timeout() -> void:
	var frogTemp = frog.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranInt = rng.randi_range(50, 2275)
	frogTemp.position = Vector2(ranInt, 100)
	add_child(frogTemp)
