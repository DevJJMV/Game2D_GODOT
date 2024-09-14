extends Node2D


func _ready():
	$AnimationPlayer.play("RotateSaw")
 


func _on_Area2D_body_entered(body):
	if body.get_name()=="Player":
		body._loseLife()
		pass
