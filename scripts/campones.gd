extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("campones")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if Dialogic.current_timeline != null:
			return
		Dialogic.start("level2")
		get_viewport().set_input_as_handled()


func _on_body_exited(body: Node2D) -> void:
	Dialogic.end_timeline()
