extends RigidBody2D

	#Nous choisissons au hasard un des trois types d'animation
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	
	# Faire en sorte que les monstres s'effacent lorsqu'ils quittent l'écran
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _process(delta: float) -> void:
	pass
