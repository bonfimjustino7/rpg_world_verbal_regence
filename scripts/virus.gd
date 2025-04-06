extends CharacterBody2D

var SPEED = 10.0
const JUMP_VELOCITY = -400.0
var player_ref: CharacterBody2D
var paused

func set_speed(sp):
	SPEED = sp
	
func accelerate_speed(sp):
	SPEED += sp
	
func decrease_speed(sp):
	SPEED -= sp


func _ready() -> void:
	$AnimatedSprite2D.play("front")

func _physics_process(delta: float) -> void:
	if paused:
		return
	
	if player_ref != null:
		var distance: Vector2 = player_ref.global_position - global_position
		var direction: Vector2 = distance.normalized()
		velocity = SPEED * direction
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play("move")
	else:
		$AnimatedSprite2D.play("front")
	
	move_and_slide()
	
func pause():
	print("Pause virus")
	paused = true
	$AnimatedSprite2D.play("front")

func resume():
	print("Continue virus")
	paused = false
	$AnimatedSprite2D.play("front")
