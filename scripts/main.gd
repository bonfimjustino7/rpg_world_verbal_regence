extends Node2D

var speed_virus = 10
var speed_player = 60
@export var virus_scene: PackedScene
@onready var player = $player
@export var number_of_viruses: int = 5


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_text_signal)
	new_game()
	

func _on_dialogic_text_signal(argument:String):
	if argument == "level1-success":
		print("Parabéns você conseguir vencer o nível 1")
	elif argument == "level2-success":
		print("Parabéns você conseguir vencer o nível 2")
	elif argument == "start_timeline":
		print("Iniciou o timeline")
		get_tree().call_group("viruses", "pause")
	
	elif argument == "end_timeline":
		print("Saiu do timeline")
		get_tree().call_group("viruses", "resume")
	
	else:
		print(argument)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func new_game():
	$player.set_speed(speed_player)	
	#populate_virus()
	

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
	print("Populando virus {number_of_viruses}", number_of_viruses)
	populate_virus()
