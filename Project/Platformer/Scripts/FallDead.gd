extends Area2D

# Call Timer node path
@onready var timer = $Timer
signal dead
# If you fall you die
func _on_body_entered(body):
	# Start dead timer
	timer.start()
	emit_signal("dead")
	$DeadSound.play()

# Respawn when dying
func _on_timer_timeout():
	# Reload Scene
	get_tree().reload_current_scene()
