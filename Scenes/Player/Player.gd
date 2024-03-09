
extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
const gravity = 900.0
enum State  { run , idle, jump , fall}
var current_state
func _ready():
	current_state = State.idle
	
	
func _physics_process(delta):
	player_idle(delta)
	player_run(delta)
	#player_jump(delta)
	player_falling(delta)
	
	move_and_slide()
	player_animation()
	
func player_idle(delta):
	if is_on_floor_only():
		current_state = State.idle
		
		
func player_falling(delta):
	if !is_on_floor():
		velocity.y = gravity*delta
		
func player_jump():
	pass
		
		
func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction and is_on_floor():
		velocity.x = direction*SPEED
		current_state = State.run
	else:
		velocity.x= move_toward(velocity.x, 0 , SPEED)
		current_state = State.idle
	
	
func player_animation():
	if current_state == State.idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.run:
		animated_sprite_2d.play("run")
