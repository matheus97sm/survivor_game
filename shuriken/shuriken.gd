extends Area2D


var shuriken_damage = 3.0


func _ready() -> void:
	play_attack()


func play_attack():
	%AnimationPlayer.play("attack")


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		get_parent().inflictDamage(body)
