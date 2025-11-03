extends Node
@onready var p1 : CharacterBody2D = %player1
var score = 0

func add_point():
	score += 1
	print("# of bears: " +  str(score))
