extends Node2D

const SPEED_VIRUS = 10
const SPEED_PLAYER = 50

var speed_virus = SPEED_VIRUS
var speed_player = SPEED_PLAYER
@export var virus_scene: PackedScene
@onready var player = $player
@export var number_of_viruses: int = 5
var pause_virus = false


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_text_signal)	
	instrutions_player()

func instrutions_player():		
	Dialogic.timeline_ended.connect(_on_instrutions_ended)
	Dialogic.start("instrutions")
	
	
func _on_instrutions_ended():
	Dialogic.timeline_ended.disconnect(_on_instrutions_ended)
	new_game()
	
func _on_dialogic_text_signal(argument:String):
	if argument == "level1-success":
		print("Parabéns você conseguir vencer o nível 1")
		response_success()
	elif argument == "level2-success":
		print("Parabéns você conseguir vencer o nível 2")
		response_success()
	elif argument == "start_timeline":
		print("Iniciou o timeline")
		get_tree().call_group("viruses", "pause")
		pause_virus = true
	elif argument == "end_timeline":
		print("Saiu do timeline")
		get_tree().call_group("viruses", "resume")
		pause_virus = false
	else:
		print(argument)		
		response_fail()


func new_game():
	$player.set_speed(speed_player)	
	speed_virus = SPEED_VIRUS
	speed_player = SPEED_PLAYER
	player.revive()
	$PopulateVirusTimer.start()
	
	
func game_over():
	print("Game ouver")
	$PopulateVirusTimer.stop()
	get_tree().call_group("viruses", "queue_free")
	$GameOverTimer.start()
	
	
func _on_game_over_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func populate_virus():
	var viewport_rect = get_viewport().get_visible_rect()  # Obtém o tamanho da tela	
	
	for i in range(number_of_viruses):
		var virus = virus_scene.instantiate()
		virus.add_to_group("viruses")

	
		# Definir posição inicial na borda direita da tela
		var spawn_x = viewport_rect.position.x  # Posição no final da tela (esquerda)
		var spawn_y = randf_range(0, viewport_rect.size.y)  # Posição aleatória na altura da tela

		virus.position = Vector2(spawn_x, spawn_y)  # Define a posição do mob	
		
		# Passa a referência do player
		virus.player_ref = player
		virus.set_speed(speed_virus)
		
		add_child(virus)


func _on_populate_virus_timer_timeout() -> void:
	if not pause_virus:
		print("Populando virus: ", number_of_viruses)
		populate_virus()
		
func response_success():
	speed_virus -= 5
	speed_player += 5
	
	if speed_virus < SPEED_VIRUS:
		speed_virus = SPEED_VIRUS
	
	if speed_player < SPEED_PLAYER:
		speed_player = SPEED_PLAYER
		
	get_tree().call_group("viruses", "decrease_speed", speed_virus)
	player.accelerate_speed(speed_player)

func response_fail():
	speed_virus += 5
	speed_player -= 5
	
	if speed_virus < SPEED_VIRUS:
		speed_virus = SPEED_VIRUS
	
	if speed_player < SPEED_PLAYER:
		speed_player = SPEED_PLAYER
	
	player.set_speed(speed_player)
	get_tree().call_group("viruses", "accelerate_speed", speed_virus)
