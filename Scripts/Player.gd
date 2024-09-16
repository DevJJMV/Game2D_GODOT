extends KinematicBody2D

# Movimiento y otras variables del jugador
const moveSpeed = 50
const maxSpeed = 80
const jumpHeight = -300
const gravity = 15
var motion = Vector2()
var is_jumping = false

# Contador de monedas
var coin_count = 0  # Variable para almacenar las monedas recolectadas

# Referencia al Sprite del jugador
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

# Referencia al AudioStreamPlayer para el sonido de salto
onready var jump_sound = $AudioStreamPlayer  # Asegúrate de que este nodo está en la escena del jugador

# Ruta de la skin azul por defecto
const default_skin_texture = "res://Rocky Roads/Enemies/slime_blue.png"

# Cargar la skin seleccionada (el PNG) o la skin azul por defecto
func _ready():
	load_selected_skin()  # Llamamos la función que cambia la textura del Sprite

func load_selected_skin():
	# Obtener la ruta de la skin seleccionada desde el SkinManager
	var selected_skin_texture_path = SkinManager.get_skin()
	
	# Si no hay skin seleccionada, usar la skin azul por defecto
	if selected_skin_texture_path == "":
		selected_skin_texture_path = default_skin_texture

	print("Cargando skin: ", selected_skin_texture_path)  # Depuración
	var new_texture = load(selected_skin_texture_path)
	sprite.texture = new_texture

# Esta función se llama cada vez que la textura del Sprite cambie
func _on_Sprite_texture_changed():
	print("La textura del sprite ha cambiado a: ", sprite.texture)

# Función para recolectar monedas y cambiar de mundo
func add_Coin():
	var canvasLayer = get_tree().get_root().find_node("CanvasLayer",true,false)
	canvasLayer.handleCoinCollected()
	coin_count += 1  # Incrementa el contador de monedas
	print("Monedas recolectadas: ", coin_count)  # Mensaje de depuración

	# Cambiar de mundo cuando se recolecten 3 monedas
	if coin_count == 3:
		coin_count = 0  # Reinicia el contador de monedas
		Global.current_world += 1  # Incrementa el número de mundo
		print("Cambiando a Mundo", Global.current_world)

		# Cargar la nueva escena del mundo
		var next_scene = "res://Scenes/Mundo" + str(Global.current_world) + ".tscn"
		var result = get_tree().change_scene(next_scene)

		# Verificar si el cambio de escena fue exitoso
		if result != OK:
			print("Error al cargar la escena: ", next_scene)
			Global.current_world = 1  # Si hay error, reinicia a Mundo1
			get_tree().change_scene("res://Scenes/Mundo1.tscn")

# Función para reproducir el sonido de salto
func play_jump_sound():
	if jump_sound and !jump_sound.playing:
		jump_sound.play()

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
			play_jump_sound()  # Reproducir sonido de salto
			is_jumping = true  # Cambiamos el estado a saltando

	else:
		# Movimiento en el aire
		if Input.is_action_pressed("ui_right"):
			sprite.flip_h = true
			motion.x = min(motion.x + moveSpeed, maxSpeed)

		elif Input.is_action_pressed("ui_left"):
			sprite.flip_h = false
			motion.x = max(motion.x - moveSpeed, -maxSpeed)

		else:
			motion.x = 0

		if is_jumping:
			animationPlayer.play("Jump")

	# Aplicar el movimiento
	motion = move_and_slide(motion, Vector2(0, -1))

func _on_Spikes_body_entered(body):
	if body.get_name() == "Player":
		print("Hemos chocado con una espina. Reiniciando el nivel...")
		get_tree().reload_current_scene()  # Esta función recarga la escena actual

func _loseLife():
	print("Hemos chocado con una sierra. Reiniciando el nivel...")
	get_tree().reload_current_scene()  # Esta función recarga la escena actual
