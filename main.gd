extends Node2D

func _ready():
	Utils.saveGame();
	Utils.loadGame();
	$MusicPlayer.play();
func _on_play_pressed() :
	$MusicPlayer.stop()
	$MusicPlayer.seek(0.0)
	Game.reset()
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_pressed() :
	get_tree().quit()
