extends Control

func _ready():
	visible=false;

func _input(event):
	if event.is_action_pressed("pause"):
		print("El juego está pausado")
		visible=not get_tree().paused
		get_tree().paused = not get_tree().paused


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
