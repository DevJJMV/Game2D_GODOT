extends CanvasLayer

var coins = 0  # Mantén las monedas locales

func _ready():
	$CoinsCollectedText.text = String(coins)
	print("Inicializando en la escena: Mundo" + str(Global.current_world))  # Usamos la variable global

func handleCoinCollected():
	print("Moneda recolectada")
	coins += 1
	$CoinsCollectedText.text = String(coins)
	print("Total de monedas: " + str(coins))  # Log para mostrar el total de monedas

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
