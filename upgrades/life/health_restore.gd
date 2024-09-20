extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("restore_life"):
		queue_free()
		body.restore_life()
