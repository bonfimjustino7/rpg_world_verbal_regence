extends CharacterBody2D

signal die_hit
signal mission_completed

@export var speed = 100
var current_dir = "none"
const HEALTH = 3
const MAX_MISSIONS = 2
var missions = 0
@export var health := HEALTH
@onready var progressBar = $ProgressBar
@onready var missionCompleted = $MissionCompleted

func _ready() -> void:
	revive()
	
func set_speed(sp):
	speed = sp
	
func accelerate_speed(sp):
	speed += sp
	
func decrease_speed(sp):
	speed -= sp
	

func complete_mission(amount = 1):
	missions += 1
	if missions > MAX_MISSIONS:
		missions = MAX_MISSIONS
	
	elif missions == MAX_MISSIONS:
		$VictorySound.play()
		mission_completed.emit()
	
	missionCompleted.value = missions

func revive():
	show()
	health = HEALTH
	missions = 0
	$AnimatedSprite2D.play("front_idle")
	progressBar.max_value = health
	progressBar.value = health
	missionCompleted.max_value = MAX_MISSIONS
	missionCompleted.value = missions
	

func take_damage(amount := 1):
	$HitSound.play()
	health -= amount
	print("🔥 Player levou dano! Vida restante:", health)
	progressBar.value = health
	if health <= 0:
		die()

func die():
	print("💀 Player morreu!")
	$GameOverSound.play()
	die_hit.emit()
	hide()
	
	

func _physics_process(delta: float) -> void:
	play_movement(delta)
	var collision_count = get_slide_collision_count()
	for i in range(collision_count):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()		

		if collider.is_in_group("virus"):			
			take_damage()
			collider.queue_free()
	
	
func play_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")

	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
