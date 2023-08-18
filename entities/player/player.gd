extends CharacterBody2D

const ARROW = preload("res://entities/arrow/arrow.tscn")
@export var speed = 300.0
var is_walking = false

func _ready():
	$AnimationTree["parameters/walk/TimeScale/scale"] = speed / 100.0

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	var mouse_position = get_global_mouse_position()
	var aim_direction = (mouse_position - position).normalized()
	
	if direction:
		is_walking = true
		_update_animation_direction(direction)
	else:
		is_walking = false
		
	_update_attack_animation(aim_direction)
	_update_animation_conditions()
		
	velocity = direction * speed

	move_and_slide()

func _update_animation_direction(direction):
	$AnimationTree["parameters/idle/blend_position"] = direction
	$AnimationTree["parameters/walk/BlendSpace2D/blend_position"] = direction


func _update_attack_animation(direction):
	if Input.is_action_just_pressed("attack"):
		$AnimationTree["parameters/conditions/attack"] = true;
		$AnimationTree["parameters/attack/BlendSpace2D/blend_position"] = direction
		$AnimationTree["parameters/idle/blend_position"] = direction
		# _attacking()
	else:
		$AnimationTree["parameters/conditions/attack"] = false;

func _update_animation_conditions():
	$AnimationTree["parameters/conditions/idle"] = !is_walking
	$AnimationTree["parameters/conditions/walking"] = is_walking

func _attacking():
	var mouse_position = get_global_mouse_position()
	var arrow = ARROW.instantiate()
	arrow.position = position
	arrow.direction = position.direction_to(mouse_position)
	get_parent().add_child(arrow)
	arrow.look_at(mouse_position)
