extends CharacterBody2D

func _physics_process(_delta):
	var direction = position.direction_to($"../Player".position)
	velocity = direction * 50

	move_and_slide()
