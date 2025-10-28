extends PathFollow2D

@export var deathPause:bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(delta: float) -> void:
	if(deathPause==true):
		progress_ratio +=0
		return
	progress_ratio +=delta * 0.02
		
	

	
	
