extends Area2D

signal coinCollected;

func _on_Coin2D_body_entered(body):
	
	if body.get_name()=="Player":
		body.add_Coin()
		queue_free()
		pass # Replace with function body.
