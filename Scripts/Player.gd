extends KinematicBody2D

# Movimiento
const moveSpeed = 30
const maxSpeed = 50

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
	motion.y += gravity
	var friction = false

	if is_on_floor():
		# Si el personaje toca el suelo, puede moverse y reproducir animaciones de caminar o idle.
		is_jumping = false  # Ya no estamos saltando porque tocamos el suelo.

		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = true
			animationPlayer.play("Walk")
			motion.x = min(motion.x + moveSpeed, maxSpeed)

		elif Input.is_action_pressed("ui_left"):
			sprite.flip_h = false
			animationPlayer.play("Walk")
			motion.x = max(motion.x - moveSpeed, -maxSpeed)

		else:
			animationPlayer.play("Idle")
			friction = true

		# Si el usuario presiona el botón de salto
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = jumpHeight
			animationPlayer.play("Jump")
			is_jumping = true  # Cambiamos el estado porque estamos saltando.

	else:
		# Mientras esté en el aire, solo reproducimos la animación de salto una vez
		if is_jumping:
			animationPlayer.play("Jump")

		# Aplicar fricción en el aire
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)

	# Aplicar fricción en el suelo
	if is_on_floor() and friction == true:
		motion.x = lerp(motion.x, 0, 0.5)

	motion = move_and_slide(motion, up)

func add_Coin():
	var canvasLayer = get_tree().get_root().find_node("CanvasLayer",true,false);
	
	canvasLayer.handleCoinCollected()
