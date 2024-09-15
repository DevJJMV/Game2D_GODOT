extends Button

# Función para cambiar la skin (almacenar la ruta de la textura seleccionada)
func change_skin(skin_texture_path):
	SkinManager.set_skin(skin_texture_path)  # Almacena la ruta de la textura seleccionada
	print("Skin seleccionada: ", skin_texture_path)  # Mensaje para verificar la skin seleccionada

# Botones de selección de skin
func _on_Default_pressed():
	change_skin("res://Rocky Roads/Enemies/slime_blue.png")  # Skin por defecto

func _on_Pink_pressed():
	change_skin("res://Rocky Roads/Enemies/slime_pink.png")  # Skin rosa

func _on_Green_pressed():
	change_skin("res://Rocky Roads/Enemies/slime_green.png")  # Skin verde

func _on_Red_pressed():
	change_skin("res://Rocky Roads/Enemies/slime_red.png")  # Skin roja

func _on_Sheriff_pressed():
	change_skin("res://Rocky Roads/Enemies/slime_sheriff.png")  # Skin de sheriff

# Volver al menú principal
func _on_ReturnMenu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
