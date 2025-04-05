extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("npc")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		show_dialog("introduction")
		get_viewport().set_input_as_handled()


func show_dialog(name):
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
		
	Dialogic.start(name)
	get_viewport().set_input_as_handled()


func _on_body_exited(body: Node2D) -> void:
	Dialogic.end_timeline()
