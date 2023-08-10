extends Node2D

var speed = 800
var direction: Vector2

func _process(delta):
	position += direction * speed * delta
