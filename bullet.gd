extends Area2D

const BULLET_SPEED = 1000.0
const BULLET_RANGE = 1200.0
var bullet_damage = 5.0
var travelled_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * BULLET_SPEED * delta
	
	travelled_distance += BULLET_SPEED * delta
	if travelled_distance > BULLET_RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(bullet_damage)
