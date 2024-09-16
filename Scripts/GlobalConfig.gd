extends Node

# Diccionario para almacenar las configuraciones de los controles
var controls_config = {
	"ui_left": "ui_left",
	"ui_right": "ui_right",
	"ui_accept": "ui_accept",
	"pause": "pause"
}

# Guardar la configuración actual de los controles
func save_controls():
	var save_data = {}
	
	# Recopilar las teclas actuales asignadas
	for action in controls_config.keys():
		var keys = InputMap.get_action_list(action)
		if keys.size() > 0:
			var key_event = keys[0]
			if key_event is InputEventKey:
				save_data[action] = key_event.scancode
	
	# Guardar en el archivo user://config_controls.cfg
	var config_file = File.new()
	config_file.open("user://config_controls.cfg", File.WRITE)
	config_file.store_string(to_json(save_data))
	config_file.close()
	print("Configuración de controles guardada correctamente.")

# Cargar la configuración de los controles
func load_controls():
	var config_file = File.new()
	
	if config_file.file_exists("user://config_controls.cfg"):
		config_file.open("user://config_controls.cfg", File.READ)
		var save_data = parse_json(config_file.get_as_text())
		config_file.close()
		
		# Asignar las teclas cargadas a las acciones
		for action in save_data.keys():
			# Borrar las teclas anteriores
			for key_event in InputMap.get_action_list(action):
				InputMap.action_erase_event(action, key_event)

			# Asignar las nuevas teclas
			var new_key_event = InputEventKey.new()
			new_key_event.set_scancode(save_data[action])
			InputMap.action_add_event(action, new_key_event)
		
		print("Configuración de controles cargada correctamente.")
	else:
		print("No se encontró archivo de configuración, usando valores por defecto.")
		save_controls()  # Guardar los controles predeterminados en el archivo si no existe

# Verificar si una tecla ya está asignada a otra acción
func is_key_already_assigned(key_code):
	for action in controls_config.keys():
		var keys = InputMap.get_action_list(action)
		if keys.size() > 0:
			var key_event = keys[0]
			if key_event is InputEventKey and key_event.scancode == key_code:
				return true  # La tecla ya está asignada a otra acción
	return false  # La tecla no está asignada a ninguna acción
