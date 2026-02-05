extends Node2D

var Cherry = preload("res://Collectables/cherry.tscn")


func _on_timer_timeout() -> void:
	var cherryTemp = Cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranInt = rng.randi_range(50, 2275)
	cherryTemp.position = Vector2(ranInt, 296)
	add_child(cherryTemp)
