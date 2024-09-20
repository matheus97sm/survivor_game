extends Area2D


var shuriken_damage = 3.0


func _ready() -> void:
	play_attack()


func play_attack():
	%AnimationPlayer.play("attack")


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("take_damage"):
		body.take_damage(shuriken_damage)
