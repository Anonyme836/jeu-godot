extends Area2D
signal hit
@export var speed = 400

@export var balle_scene: PackedScene

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	#On utilise hide() pour que le joueur soit cacher au début
	hide()
	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 11
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		#le $ est esquivallent a get_node se qui fait: get_node("AnimatedSprite2D").play()
		
		#Ici on empeche le fait de pouvoir sortir de l'cran grasse a: clamp()
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
	else:
		$AnimatedSprite2D.stop()
		
	#La on fait en sorte que les annimations pour quand on va en haut en bas etc se mettent en placent
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	$tire/Timer.stop()

#commande pour réinitialiser le joueur au début d'une nvl partie
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	$tire/Timer.start()

func _on_tire_je_tir() -> void:
	var shoot:CharacterBody2D = balle_scene.instantiate()

	shoot.global_position = global_position
	get_parent().add_child(shoot)
	shoot.look_at(get_global_mouse_position())

	# Spawn the mob by adding it to the Main scene.
