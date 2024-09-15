extends Node

var current_skin_scene = "res://Scenes/Player.tscn"  # Skin por defecto

func set_skin(skin_scene_path):
	current_skin_scene = skin_scene_path

func get_skin():
	return current_skin_scene


func _on_Sprite_texture_changed():
	pass # Replace with function body.
