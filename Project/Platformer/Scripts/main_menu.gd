extends CanvasLayer


signal start


func _on_play_button_pressed():
	emit_signal("start")
	hide()
