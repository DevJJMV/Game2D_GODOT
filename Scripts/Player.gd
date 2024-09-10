extends KinematicBody2D

# Movimiento
const moveSpeed = 50
const maxSpeed = 80

# Salto
const jumpHeight = -300
const up = Vector2(0, -1)

# Gravedad
const gravity = 15

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

# Movimiento
var motion = Vector2()

# Estado para verificar si el personaje está en el aire
var is_jumping = false

# Físicas del jugador
func _physics_process(delta):
	motion.y += gravity  # Siempre aplicamos gravedad

	if is_on_floor():
		is_jumping = false  # Ya no estamos saltando porque tocamos el suelo.

		# Movimiento a la derecha
		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = true
			animationPlayer.play("Walk")
			motion.x = min(motion.x + moveSpeed, maxSpeed)

		# Movimiento a la izquierda
		elif Input.is_action_pressed("ui_left"):
			sprite.flip_h = false
			animationPlayer.play("Walk")
			motion.x = max(motion.x - moveSpeed, -maxSpeed)

		else:
			animationPlayer.play("Idle")
			motion.x = lerp(motion.x, 0, 0.5)  # Aplicar fricción en el suelo

		# Si el usuario presiona el botón de salto
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = jumpHeight
			animationPlayer.play("Jump")
			is_jumping = true  # Cambiamos el estado a saltando

	else:
		# Mientras esté en el aire, permitir movimiento lateral solo cuando se presionan teclas
		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = true
			motion.x = min(motion.x + moveSpeed, maxSpeed)

		elif Input.is_action_pressed("ui_left"):
			sprite.flip_h = false
			motion.x = max(motion.x - moveSpeed, -maxSpeed)

		else:
			# Si estamos en el aire y no se presiona ningún botón, detener el movimiento horizontal
			motion.x = 0

		# Reproducimos la animación de salto solo cuando estamos en el aire
		if is_jumping:
			animationPlayer.play("Jump")

	# Aplicar movimiento
	motion = move_and_slide(motion, up)

func add_Coin():
	var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true, false)
	canvasLayer.handleCoinCollected()

func _on_Spikes_body_entered(body):
	if body.get_name() == "Player":
		print("Hemos chocado con un pincho")
		get_tree().reload_current_scene()
