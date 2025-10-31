extends CharacterBody2D
@onready var cam: PathFollow2D=$"../cameraPath/CamFollowPath"
@onready var animatedSprite: AnimatedSprite2D=$AnimatedSprite2D
const SPEED = 100.0
const JUMP_VELOCITY = -250.0
const DASH_SPEED=400
@onready var dash_timer:Timer=$dash_timer2
@onready var P1:CharacterBody2D=$"../player1"
@onready var can_dash_timer:Timer=$can_dash_timer2
@onready var Trail:Line2D=$Trail2D
var dashing=false
var can_dash=true
var default=true

func _physics_process(delta: float) -> void:
	if(P1.won):
		animatedSprite.play("win")
		return
	if not dashing:
		Trail.visible=false
	else:
		Trail.visible=true
	HandleAnimation()
	if cam.deathPause:
		animatedSprite.play("death")
		return
	if velocity.x==0 and velocity.y==0:
		animatedSprite.play("default")
	if velocity.y>0:
		animatedSprite.play("jump")
		
	if not is_on_floor():
		velocity.y += 700* delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpP2") and is_on_floor():
		animatedSprite.play("jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_leftP2", "move_rightP2")
	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
	
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("DashP2") and can_dash:
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

func _on_can_dash_timer_2_timeout() -> void:
	can_dash=true


func _on_dash_timer_2_timeout() -> void:
	dashing=false
