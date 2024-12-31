extends Node

class_name LevelManager

var coins = 0

func on_coin_collected():
	coins += 1
	print("coin")
