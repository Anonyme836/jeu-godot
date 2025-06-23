extends CharacterBody2D

@export var SPEED : Vector2 = Vector2(250,0)

func _physics_process(delta: float) -> void:
	velocity = SPEED
	move_and_slide()
