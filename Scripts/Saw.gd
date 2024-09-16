extends Node2D  # Cambiado de Node2D a Area2D

func _ready():
	$AnimationPlayer.play("RotateSaw")  # Iniciar la animación de rotación de la sierra

# Función llamada cuando el jugador colisiona con la sierra
func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		print("Colisión con la sierra detectada")
		body._loseLife()  # Llamamos a la función del jugador para reiniciar el nivel
