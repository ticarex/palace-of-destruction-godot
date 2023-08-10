extends CharacterBody2D

const ARROW = preload("res://entities/arrow/arrow.tscn")
@export var speed = 300

var _walking = false

func _ready():
	$AnimationTree["parameters/walk/TimeScale/scale"] = speed / 100.0

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		_walking = true
		$AnimationTree["parameters/idle/blend_position"] = direction
		$AnimationTree["parameters/walk/BlendSpace2D/blend_position"] = direction
	else:
		_walking = false
		
	$AnimationTree["parameters/conditions/idle"] = !_walking
	$AnimationTree["parameters/conditions/walking"] = _walking
		
	velocity = direction * speed

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		var mouse_pos = get_global_mouse_position()
		
		var arrow = ARROW.instantiate()
		arrow.position = position
		arrow.direction = position.direction_to(mouse_pos)
		get_parent().add_child(arrow)
		arrow.look_at(mouse_pos)
