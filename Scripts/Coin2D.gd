extends Area2D

signal coinCollected

func _on_Coin2D_body_entered(body):
	
	if body.get_name() == "Player":
		$AudioStreamPlayer.playing = true
		emit_signal("coinCollected")
		body.add_Coin()
		# Acá va la línea de código para desaparecer la moneda con visible=false
		self.visible = false  # La moneda desaparece (no se muestra más en la escena)
		yield(get_tree().create_timer(0.5), "timeout")
		
		queue_free()  # Luego de 0.5 segundos, la moneda se elimina de la escena
		
