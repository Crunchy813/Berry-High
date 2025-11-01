extends AnimatableBody2D
@onready var playerleft: CharacterBody2D = $"../../player1"
@onready var playerright: CharacterBody2D = $"../../player2"
@onready var animations: AnimationPlayer =  get_tree().get_root().get_node("/root/level/BlocksAnimationPlayer")

var done = false
@export var BlockNumber: int = 0
@export var GoLeftMode: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:

	if (playerleft.dashing) and not done and not GoLeftMode:
		print("entered anim1")
		animations.play("move" + str(BlockNumber))
		done = true


func _on_area_2_dright_body_entered(body: CharacterBody2D) -> void:
	if (playerright.dashing) and not done and GoLeftMode:
		animations.play("move" + str(BlockNumber))
		done = true
