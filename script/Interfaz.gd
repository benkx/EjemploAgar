extends CanvasLayer
signal iniciar_juego

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func mostrar_texto(texto):
	$TitleLabel.text = texto
	$TitleLabel.show()
	$Timer_title.start()

func game_over():
	mostrar_texto('Game Over')
	yield($Timer_title, "timeout")
	$btnplay.show()
	$TitleLabel.text = "Agar_Example"
	$TitleLabel.show()
# Called when the node enters the scene tree for the first time.

func update_score(score):
	$ScoreLabel.text = str(score)
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_title_timeout():
	$TitleLabel.hide()


func _on_btnplay_pressed():
	$btnplay.hide()
	emit_signal("iniciar_juego")
