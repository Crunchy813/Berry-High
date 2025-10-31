extends PathFollow2D

@export var deathPause:bool
@onready var P1:CharacterBody2D=$"../../player1"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	P1.won=false
	

# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta: float) -> void:
	if deathPause==true or P1.won==true:
		progress_ratio +=0
		return
	#progress_ratio +=delta * 0.02
		
	

	
	
