extends Node


var playerHP = 10
var Gold = 0

func set_hp(value):
	playerHP = clamp(value, 0, 10)
