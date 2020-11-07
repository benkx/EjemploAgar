extends RigidBody2D

export(int) var velocidad_min
export(int) var velocidad_max
var tipo_cirlce = ['enemy1', 'enemy2','enemy3']

func _ready():
	$AnimatedSprite.animation = tipo_cirlce[randi() % tipo_cirlce.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
