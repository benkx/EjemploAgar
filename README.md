#  Patrones de Diseños

Los patrones de diseño son unas técnicas para resolver problemas comunes en el desarrollo de software y otros ámbitos referentes al diseño de interacción o interfaces.

Un patrón de diseño resulta ser una solución a un problema de diseño. Para que una solución sea considerada un patrón debe poseer ciertas características. 
Una de ellas es que debe haber comprobado su efectividad resolviendo problemas similares en ocasiones anteriores. Otra es que debe ser reutilizable, 
lo que significa que es aplicable a diferentes problemas de diseño en distintas circunstancias

## Contexto del Ejercicio   📋

Desarrollar el Juego Agar.io el cual permite en el juego incrementar el circulo a medida que se coma a otros oponentes mas pequeños, hasta que otro oponente mas grande se lo coma,
para dar por terminado el juego

## Patrones de Diseños que se Aplicaran ✒️

- Patron de diseño Composite
- Patron de diseño Bridge
- Patron de diseño Flyweight

### Patron de diseño Composite
Combina objetos en estructuras de árbol para representar jerarquías de parte-todo. Permite que los clientes traten de manera uniforme a los objetos individuales y a los compuestos.
```
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
	
  ```
  ### Patron de diseño Bridge
  Desvincula una abstracción de su implementación, de manera que ambas puedan variar de forma independiente.
 ```
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

```

 ### Patron de diseño Flyweight
  
  Usa el compartimiento para permitir un gran número de objetos de grano fino de forma eficiente.
  
 ```
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
```

## Como Ejecutar

Se requiere ejercutar en el Xammp en Apache

## Autores ✒️

_Menciona a todos aquellos que ayudaron a levantar el proyecto desde sus inicios_

* **Rhosben Cordoba** - *Trabajo Inicial* - [benkx](https://github.com/benkx)
* **Fulanito Detal** - *Documentación* - [fulanitodetal](#fulanito-de-tal)
  
