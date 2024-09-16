extends Control

# Variable para almacenar la acción que se está cambiando
var action_to_change = ""  

# Referencias a los Labels que muestran las teclas actuales asignadas
onready var label_left = $Felft/LeftLabel  # Label para mostrar la tecla asignada a "Mover a la izquierda"
onready var label_right = $Right/RightLabel  # Label para mostrar la tecla asignada a "Mover a la derecha"
onready var label_jump = $Jump/JumpLabel  # Label para mostrar la tecla asignada a "Saltar"
onready var label_pause = $Pause/PauseLabel  # Label para mostrar la tecla asignada a "Pausar"

# Llamado cuando el nodo entra en la escena
func _ready():
	GlobalConfig.load_controls()  # Cargar la configuración de los controles al iniciar
	update_labels()

# Actualiza los Labels con las teclas actuales asignadas
func update_labels():
	label_left.text = get_current_key("ui_left")
	label_right.text = get_current_key("ui_right")
	label_jump.text = get_current_key("ui_accept")
	label_pause.text = get_current_key("pause")

# Obtener la tecla actual asignada a una acción
func get_current_key(action):
	var keys = InputMap.get_action_list(action)
	if keys.size() > 0:
		var key_event = keys[0]  # Tomar la primera tecla asignada
		if key_event is InputEventKey:
			return OS.get_scancode_string(key_event.scancode)
	return "No asignado"

# Función que se llama cuando se presiona un botón para cambiar una tecla
func _on_Right_pressed():
	action_to_change = "ui_right"  # Cambiar la acción de moverse a la derecha
	print("Selecciona una nueva tecla para: Mover a la derecha")

func _on_Pause_pressed():
	action_to_change = "pause"  # Cambiar la acción de pausar
	print("Selecciona una nueva tecla para: Pausa")

func _on_Felft_pressed():
	action_to_change = "ui_left"  # Cambiar la acción de moverse a la izquierda
	print("Selecciona una nueva tecla para: Mover a la izquierda")

func _on_Jump_pressed():
	action_to_change = "ui_accept"  # Cambiar la acción de saltar
	print("Selecciona una nueva tecla para: Saltar")

# Detectar la nueva tecla presionada y reasignar la acción
func _input(event):
	if action_to_change != "" and event is InputEventKey and event.pressed:
		var key_code = event.scancode
		print("Tecla seleccionada: ", OS.get_scancode_string(key_code))

		# Verificar si la tecla ya está asignada a otra acción
		if GlobalConfig.is_key_already_assigned(key_code):
			print("Error: Esta tecla ya está asignada a otra acción.")
			return  # No hacer nada si la tecla ya está en uso

		# Eliminar la tecla anterior de la acción
		for key_event in InputMap.get_action_list(action_to_change):
			InputMap.action_erase_event(action_to_change, key_event)

		# Asignar la nueva tecla
		var new_key_event = InputEventKey.new()
		new_key_event.set_scancode(key_code)
		InputMap.action_add_event(action_to_change, new_key_event)
		
		print("La acción '", action_to_change, "' ha sido asignada a la tecla: ", OS.get_scancode_string(key_code))
		
		# Guardar la configuración después de cambiar la tecla
		GlobalConfig.save_controls()
		
		# Actualizar los labels después de cambiar la tecla
		update_labels()
		
		action_to_change = ""  # Restablecer la variable para la próxima acción

func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
