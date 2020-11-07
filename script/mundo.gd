extends Node
export (PackedScene) var circle
export (int) var score

func _ready():
	randomize()

func nuevo_juego():
	score = 0
	$Player.inicio($Position2D.position)
	$InicioTimer3.start()
	$Interfaz.mostrar_texto('Listo!')
	$Interfaz.update_score(score)

func game_over():
	$ScoreTimer2.stop()
	$RocaTimer.stop()
	$Interfaz.game_over()


func _on_InicioTimer3_timeout():
	$ScoreTimer2.start()
	$RocaTimer.start()


func _on_ScoreTimer2_timeout():
	score += 1
	$Interfaz.update_score(score)
	$Player.scale.x += 0.05
	$Player.scale.y += 0.05
	
func _on_RocaTimer_timeout():
	$Path2D/PathFollow2D.set_offset(randi())
	var r = circle.instance()
	r.scale.x += 0.1
	r.scale.y += 0.1
	add_child(r)
	var d = $Path2D/PathFollow2D.rotation + PI / 2
	
	r.position = $Path2D/PathFollow2D.position
	d +=  rand_range(-PI /4, PI /4 )
	r.rotation = d
	r.set_linear_velocity(Vector2(rand_range(r.velocidad_min , r.velocidad_max), 0).rotated(d))
	
