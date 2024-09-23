extends Area2D


@onready var player = get_node("/root/Game/Player")

const MAX_ATTACK_DAMAGE = 40
const MAX_ATTACK_SPEED = 5
var attack_damage = 0.0
var attack_speed = 0.0


func _physics_process(delta: float) -> void:
	if attack_speed == 0:
		visible = false
		return 
		
	visible = true
	rotation += attack_speed * delta


func inflictDamage(body: Node2D) -> void:
	var utils = Utils.new()
	var inflicted_damage = utils.calculate_damage(attack_damage, player)
	
	body.take_damage(inflicted_damage)

func upgrade_weapon() -> void:
	if attack_speed == 0:
		attack_damage = 3
		attack_speed = 1
		return
	
	var new_attack_damage = attack_damage + roundf(attack_damage * 0.35)
	var new_attack_speed = attack_speed + attack_speed * 0.2
	
	if new_attack_damage > MAX_ATTACK_DAMAGE:
		new_attack_damage = MAX_ATTACK_DAMAGE
		
	if new_attack_speed > MAX_ATTACK_SPEED:
		new_attack_speed = MAX_ATTACK_SPEED
	
	attack_damage = new_attack_damage
	attack_speed = new_attack_speed
