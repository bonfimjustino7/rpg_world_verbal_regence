extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_text_signal)

func _on_dialogic_text_signal(argument:String):
	if argument == "level1-success":
		print("Parabéns você conseguir vencer o nível 1")
	if argument == "level2-success":
		print("Parabéns você conseguir vencer o nível 2")
	else:
		print(argument)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
