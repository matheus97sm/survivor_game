extends Area2D


@export var item: InventoryItem


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		queue_free()
		body.collect(item)
		body.upgrade_weapon("damage")
