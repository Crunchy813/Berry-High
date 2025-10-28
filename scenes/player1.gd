extends CharacterBody2D
@onready var p2: CharacterBody2D=$"../player2"
@onready var cam: PathFollow2D =$"../cameraPath/CamFollowPath"
@onready var animatedSprite:AnimatedSprite2D=$AnimatedSprite2D
@onready var dash_timer:Timer=$dash_timer1
@onready var can_dash_timer:Timer=$can_dash_timer1
var dashing=false
const SPEED = 100.0
const JUMP_VELOCITY = -370.0
const DASH_SPEED=400
var can_dash=true
@export var animationsFliped:bool= false
@export var going_Right:bool=false
#when we add our own animations we make the default to the left.but
#when the charecter changes direction we change the bool value right(or an if statement for velocity
#and that bool is true we do the flipH and bring it back when it changes direction again ill try it on dash for now

func _physics_process(delta: float) -> void:



	if cam.deathPause:
		animatedSprite.play("death")
		return
	if velocity.x==0 and velocity.y==0:
		animatedSprite.play("default")
	if velocity.y>0:
		animatedSprite.play("jump")
	var direction := Input.get_axis("move_leftP1", "move_rightP1")
	if not is_on_floor() and not dashing:
		velocity.y += 500 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpP1") and is_on_floor():
		animatedSprite.play("jump")
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
		if(direction>0):
			animatedSprite.play("dash")
		else:
			animatedSprite.play("dash")
	move_and_slide()
	
		
func killPlayer():
	cam.deathPause=true
	
	
func _on_CamDangerZone_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		killPlayer()



func _on_animated_sprite_2d_animation_looped() -> void:
	if animatedSprite.animation=="death":
			cam.progress=0.0
			cam.deathPause=false
			position=$"../P1Respawn".position
			p2.position=$"../P2Respawn".position
			print("reset")
			animatedSprite.play("default")

		
func update_animation():
	if velocity.x==0 and velocity.y==0:
		animatedSprite.play("default")
		return
	if velocity.y>0:
		animatedSprite.scale.x=sign(velocity.x)
		animatedSprite.play("jump")
	if velocity.y==0 and not velocity.x==0 and not dashing:
		animatedSprite.scale.x=sign(velocity.x)
		animatedSprite.play("run")
	if dashing:
		animatedSprite.scale.x=sign(velocity.x)
		animatedSprite.play("dash")

func _on_dash_timer_timeout() -> void:
	dashing=false
	

func _on_can_dash_timer_timeout() -> void:
	can_dash=true
