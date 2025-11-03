extends Area2D
@export var checked= false
@onready var Sprite:AnimatedSprite2D=$AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		checked=true
		if not checked:
			Sprite.play()

func _on_animated_sprite_2d_animation_looped() -> void:
	Sprite.pause()
