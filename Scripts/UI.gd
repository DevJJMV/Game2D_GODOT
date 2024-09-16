extends CanvasLayer

var coins = 0  # Mantén las monedas locales
const MAX_WORLDS = 4  # Cambia este número según tus mundos

func _ready():
	$CoinsCollectedText.text = String(coins)
	print("Inicializando en la escena: Mundo" + str(Global.current_world))
	call_deferred("_connect_coin_signals")  # Diferir la conexión de señales

func _connect_coin_signals():
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("coinCollected", self, "handleCoinCollected")

func handleCoinCollected():
	print("Moneda recolectada")
	coins += 1
	$CoinsCollectedText.text = String(coins)
	print("Total de monedas: " + str(coins))

	# Cambiar de mundo si se recolectan 3 monedas
	if coins == 3:
		coins = 0  # Reinicia el contador de monedas
		Global.current_world += 1  # Incrementa el número de mundo

		if Global.current_world > MAX_WORLDS:
			Global.current_world = 1  # Reinicia al Mundo1 si supera el máximo

		var next_scene_path = "res://Scenes/Mundo" + str(Global.current_world) + ".tscn"

		# Verificar si la escena existe
		if not ResourceLoader.exists(next_scene_path):
			print("La escena " + next_scene_path + " no existe. Reiniciando a Mundo1.")
			Global.current_world = 1
			next_scene_path = "res://Scenes/Mundo1.tscn"

		print("Cambiando a la siguiente escena: " + next_scene_path)

		var result = get_tree().change_scene(next_scene_path)

		if result != OK:
			print("Error al cargar la escena: " + next_scene_path)
