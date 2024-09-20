extends Area2D


var attack_damage = 0.0
var attack_speed = 0.0


func _physics_process(delta: float) -> void:
	if attack_speed == 0:
		visible = false
		return 
		
	visible = true
	rotation += attack_speed * delta


func inflictDamage(body: Node2D) -> void:
	body.take_damage(attack_damage)
	

func upgrade_weapon() -> void:
	if attack_speed == 0:
		attack_damage = 3
		attack_speed = 1
		return
	
	attack_damage += roundf(attack_damage * 0.35)
	attack_speed += attack_speed * 0.2
