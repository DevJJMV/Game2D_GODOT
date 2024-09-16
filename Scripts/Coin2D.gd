extends Area2D

signal coinCollected

func _ready():
	add_to_group("coins")  # Añadir la moneda al grupo "coins"
	var ui_node = get_tree().get_root().get_node("CanvasLayer")  # Ajusta la ruta si es necesario
	if ui_node:
		connect("coinCollected", ui_node, "handleCoinCollected")
	else:
		print("No se encontró el nodo CanvasLayer")

func _on_Coin2D_body_entered(body):
	if body.get_name() == "Player":
		$AudioStreamPlayer.play()  # Reproduce el sonido correctamente
		emit_signal("coinCollected")
		self.visible = false
		set_deferred("monitoring", false)  # Desactiva la detección de colisiones
		call_deferred("queue_free")  # Libera el nodo de forma segura
