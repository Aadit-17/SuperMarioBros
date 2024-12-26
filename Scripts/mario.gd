extends CharacterBody2D

class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PlayerMode {
	SMALL,
	BIG,
	SHOOTING
}

#References
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_collision_shape = $Area2D/AreaCollisionShape
@onready var body_collision_shape = $BodyCollisionShape

@export_group("Locomotion")
@export var run_speed_damping = 0.5
@export var speed = 200.0
@export var jump_velocity = -350
@export_group("")

var player_mode = PlayerMode.SMALL

func _physics_process(delta):
	#Apply Gravity
	if not is_on_floor():
		velocity.y += gravity*delta
	
	#Handle Jumps
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
	
	#Handle horizontal movement
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = lerpf(velocity.x, speed*direction, run_speed_damping*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed*delta)
	
	animated_sprite_2d.trigger_animation(velocity, direction, player_mode)
	
	
	move_and_slide()

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
