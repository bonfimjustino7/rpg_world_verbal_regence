extends CanvasLayer

var main = preload("res://scenes/main.tscn")

func _ready() -> void:
	pass
	#$NameGame.text = "Regence Verbal! The Origin"

func show_message(text):
	pass
	#$NameGame.text = text
	#$NameGame.show()
	#$MessageTimer.start()


func show_game_over():
	#show_message("Game Over")
	## Wait until the MessageTimer has counted down.
	#await $MessageTimer.timeout
#
	#$NameGame.text = "Prepare-se...Vamos salvar a RegenceLand do vírus."
	#$NameGame.show()
	## Make a one-shot timer and wait for it to finish.
	#await get_tree().create_timer(1.0).timeout
	$StartButton.show()		


#func _on_message_timer_timeout() -> void:
	##$NameGame.hide()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	
	Dialogic.timeline_ended.connect(_on_introduction_ended)
	Dialogic.start("introduction")
	
	
func _on_introduction_ended():
	Dialogic.timeline_ended.disconnect(_on_introduction_ended)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
