extends Area2D

export (int) var velocidad
var movimiento = Vector2()
var limite

signal golpe

func _ready():
	limite = get_viewport_rect().size

func _physics_process(delta):
	movimiento = Vector2()
	if (Input.is_action_pressed("ui_right")):
		movimiento.x +=1
	if (Input.is_action_pressed("ui_left")):
		movimiento.x -=1
	if (Input.is_action_pressed("ui_up")):
		movimiento.y -=1
	if (Input.is_action_pressed("ui_down")):
		movimiento.y +=1
		
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad
		
	position += movimiento * delta
	position.x = clamp(position.x, 0 , limite.x)
	position.y = clamp(position.y, 0 , limite.y)


func _on_Area2D_body_entered(body):
	hide()
	emit_signal("golpe")
	$CollisionShape2D.disabled = true
	
func inicio(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
