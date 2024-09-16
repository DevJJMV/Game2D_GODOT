extends Node

var current_skin_scene = "res://Rocky Roads/Enemies/slime_blue.png"  # Skin azul por defecto

func set_skin(skin_scene_path):
	current_skin_scene = skin_scene_path

func get_skin():
	return current_skin_scene
