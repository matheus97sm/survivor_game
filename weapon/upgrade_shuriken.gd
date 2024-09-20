extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("upgrade_weapon"):
		queue_free()
		body.upgrade_shuriken()
