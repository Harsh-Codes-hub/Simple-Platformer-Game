extends Node


var playerHP: int = 10
var Gold: int = 0

func set_hp(value):
	playerHP = clamp(value, 0, 10)

func reset():
	playerHP = 10
	Gold = 0
