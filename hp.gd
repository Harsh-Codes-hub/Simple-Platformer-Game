extends Label

func _process(delta) -> void:
	text = "❤️: " + str(Game.playerHP)
