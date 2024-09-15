extends Control

# Llamado cuando el nodo entra en la escena
func _ready():
	$VBoxContainer/StartGameButton.grab_focus()

# Función para iniciar el juego
func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Scenes/Mundo1.tscn")

# Función para salir del juego
func _on_QuitButton_pressed():
	get_tree().quit()
	
func _on_Skins_pressed():
	# Aquí va la lógica que se debe ejecutar cuando se presiona el botón de skins
	print("Botón de skins presionado")
	get_tree().change_scene("res://Scenes/Skins.tscn")


func _on_Options_pressed():
	pass # Replace with function body.
