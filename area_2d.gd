extends Area2D
@onready var gamemanager: Node =%GameManager
@onready var Sprite:AnimatedSprite2D= $BearSmall
var collected=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: CharacterBody2D) -> void:
	collected=true
	Sprite.play("Collected")
	

func _on_heart_animation_looped() -> void:
	if Sprite.animation=="Collected":
		gamemanager.add_point()
		queue_free()
