extends Control

# Referencia al AudioStreamPlayer para la música de fondo y los sonidos de los botones
onready var background_music = $AudioStreamPlayerBackground  # Nodo para la música de fondo
onready var button_sound = $AudioStreamPlayerButton  # Nodo para el sonido del botón

# Llamado cuando el nodo entra en la escena
func _ready():
	$VBoxContainer/StartGameButton.grab_focus()


# Función para iniciar el juego
func _on_StartGameButton_pressed():
	play_button_sound()  # Reproduce el sonido al presionar el botón
	get_tree().change_scene("res://Scenes/Mundo1.tscn")

# Función para salir del juego
func _on_QuitButton_pressed():
	play_button_sound()  # Reproduce el sonido al presionar el botón
	get_tree().quit()
	
func _on_Skins_pressed():
	play_button_sound()  # Reproduce el sonido al presionar el botón
	print("Botón de skins presionado")
	get_tree().change_scene("res://Scenes/Skins.tscn")

func _on_Options_pressed():
	play_button_sound()  # Reproduce el sonido al presionar el botón
	get_tree().change_scene("res://Scenes/Control.tscn")  # Reemplazar con la lógica adecuada

# Función para reproducir el sonido del botón
func play_button_sound():
	if button_sound and !button_sound.playing:
		button_sound.play()
