extends CharacterBody2D
@onready var p2: CharacterBody2D=$"../player2"
@onready var cam: PathFollow2D =$"../cameraPath/CamFollowPath"
@onready var animatedSprite:AnimatedSprite2D=$AnimatedSprite2D
@onready var dash_timer:Timer=$dash_timer1
@onready var can_dash_timer:Timer=$can_dash_timer1
@onready var Trail:Line2D=$Trail2D
@onready var Hearts:CPUParticles2D=$CPUParticles2D
@onready var BlocksAnimations: AnimationPlayer = %BlocksAnimationPlayer
@onready var C1:Area2D=$"../CheckPoint1"
@onready var C1Spawn1:Node2D=$"../C1Spawn1"
@onready var C1Spawn2:Node2D=$"../C1Spawn2"
var dashing=false
const SPEED = 100.0
const JUMP_VELOCITY = -220.0
const DASH_SPEED=300
var can_dash=true
var won=false

func _physics_process(delta: float) -> void:
	if not won: 
		Hearts.emitting=false
	else:
		animatedSprite.play("win")
		Hearts.emitting=true
		return
	if dashing: 
		Trail.visible=true
	else:
		Trail.visible=false
	if cam.deathPause:
		animatedSprite.play("death")
		return
	if won:
		animatedSprite.play("win")
		return
	HandleAnimation()
		
	var direction := Input.get_axis("move_leftP1", "move_rightP1")
	if not is_on_floor() and not dashing:
		velocity.y += 300 * delta
	# Handle jump.
	if Input.is_action_just_pressed("jumpP1") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
				
	
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	if Input.is_action_just_pressed("DashP1") and can_dash:
		velocity.y=0;
		dashing=true
		can_dash=false
		can_dash_timer.start()
		dash_timer.start()
	move_and_slide()
	
		
func killPlayer():
	cam.deathPause=true
	BlocksAnimations.play("RESET")
	
func _on_CamDangerZone_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		killPlayer()



func _on_animated_sprite_2d_animation_looped() -> void:
	if animatedSprite.animation=="death":
			cam.deathPause=false
			animatedSprite.play("default")
			if C1.checked:
				cam.progress=511.35
				position=C1Spawn1.position
				p2.position=C1Spawn2.position
				return
			else:
				cam.progress=0.0
				position=$"../P1Respawn".position
				p2.position=$"../P2Respawn".position


func _on_dash_timer_timeout() -> void:
	dashing=false
	

func _on_can_dash_timer_timeout() -> void:
	can_dash=true


func HandleAnimation()-> void:
	#JUMP
	if velocity.y!=0:
		if velocity.x<0:
			animatedSprite.play("jumpLeft")
		if velocity.x>0:
			animatedSprite.play("jumpRight")
		if velocity.x==0:
			animatedSprite.play("jumpUp")
	#DAHSING
	elif (dashing):
		if velocity.x>0:
			animatedSprite.play("dashRight")
		if velocity.x<0:
			animatedSprite.play("dashLeft")
	#RUN
	elif velocity.x!=0 and velocity.y==0:
		if velocity.x<0:
			animatedSprite.play("runLeft")
		if velocity.x>0:
			animatedSprite.play("runRight")
	elif velocity.x==0 and velocity.y==0: 
		animatedSprite.play("default")

	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body== $"../player2":
		won=true
		


func _on_spikes_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		killPlayer()
	
