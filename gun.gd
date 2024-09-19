extends Area2D

@onready var damage_label = get_node("/root/Game/UI/ColorRect/AttackPowerValueLabel")
@onready var speed_label = get_node("/root/Game/UI/ColorRect/AttackSpeedValueLabel")

var maximum_shooting_speed = 0.15
var shooting_speed = 0.3
var shooting_damage = 5.0

func _ready() -> void:
	damage_label.text = str(shooting_damage)
	speed_label.text = str(shooting_speed)

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.bullet_damage = shooting_damage
	%ShootingPoint.add_child(new_bullet)

func upgrade_weapon_speed():
	var new_shooting_speed = shooting_speed - shooting_speed * 0.15
	if shooting_speed > maximum_shooting_speed:
		var utils = Utils.new()
		var rounded_shooting_speed = utils.round_to_dec(new_shooting_speed, 2)
		shooting_speed = rounded_shooting_speed
		speed_label.text = str(rounded_shooting_speed)
		%ShootingTimer.wait_time = rounded_shooting_speed

func upgrade_weapon_damage():
	shooting_damage += round(shooting_damage * 0.2)
	damage_label.text = str(shooting_damage)

func _on_timer_timeout() -> void:
	shoot()

func _on_player_weapon_upgrade(upgrade_type) -> void:
	print(upgrade_type)
	if upgrade_type == "speed":
		upgrade_weapon_speed()
	if upgrade_type == "damage":
		upgrade_weapon_damage()
