extends Node2D
@onready var pathfolow: PathFollow2D=$cameraPath/CamFollowPath
@onready var playerAnimation: AnimatedSprite2D=$AnimatedSprite2D
@onready var P1: CharacterBody2D=$player1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathfolow.deathPause=false
	P1.won=false
	pathfolow.progress=0.0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
