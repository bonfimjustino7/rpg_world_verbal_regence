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
		
		Dialogic.timeline_ended.connect(_on_dialog_ended)
		Dialogic.signal_event.emit("start_timeline")
		Dialogic.start("level2")
	


func _on_body_exited(body: Node2D) -> void:
	Dialogic.end_timeline()


func _on_dialog_ended():	
	Dialogic.timeline_ended.disconnect(_on_dialog_ended)
	Dialogic.signal_event.emit("end_timeline")
