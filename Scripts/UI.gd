extends CanvasLayer

var coins = 0  # Mantén las monedas locales

func _ready():
	
	# Conectar la señal emitida por la moneda
	for coin in get_tree().get_nodes_in_group("coins"):  # Asegúrate de que las monedas pertenezcan a un grupo llamado "coins"
		coin.connect("coinCollected", self, "handleCoinCollected")

	$CoinsCollectedText.text = String(coins)
	print("Inicializando en la escena: Mundo" + str(Global.current_world))  # Usamos la variable global

	# Función que maneja la recolección de monedas
func handleCoinCollected():
	print("Moneda recolectada")
	coins += 1
	$CoinsCollectedText.text = String(coins)  # Actualiza el texto del Label con el número de monedas
	print("Total de monedas: " + str(coins))  # Log para mostrar el total de monedas

		# Cambiar de mundo si se recolectan 3 monedas
	if coins == 3:
		coins = 0  # Reinicia el contador de monedas
		Global.current_world += 1  # Incrementa el número de mundo en la variable global

		var next_scene_path = "res://Scenes/Mundo" + str(Global.current_world) + ".tscn"
		print("Cambiando a la siguiente escena: " + next_scene_path)  # Log para mostrar la siguiente escena

		var result = get_tree().change_scene(next_scene_path)

			# Verificar si el cambio de escena fue exitoso
		if result != OK:
			print("Error al cargar la escena: " + next_scene_path)
			Global.current_world = 1  # Si hay error, reinicia a Mundo1
			get_tree().change_scene("res://Scenes/Mundo1.tscn")
