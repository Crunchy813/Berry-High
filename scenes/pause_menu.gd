extends Control
func _ready():
	%AnimationPlayer.play("RESET")
	hide()

func resume(): 
	get_tree().paused = false
	%AnimationPlayer.play_backwards("opacity")
	hide()
	
func pause():
	get_tree().paused = true
	%AnimationPlayer.play("opacity")
	show()
	
func testEsc(): 
	if Input.is_action_just_pressed("esc") && !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") && get_tree().paused:
		resume()



func _on_resume_pressed() -> void:
	resume()


func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(delta):
	testEsc()
