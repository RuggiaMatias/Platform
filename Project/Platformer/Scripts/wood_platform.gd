extends AnimatableBody2D


@export var speed = 2

func _physics_process(delta):
	var direction = Vector2.DOWN
	position += direction * speed

