extends Area2D

@onready var player = get_node("/root/Game/Player")

var maximum_shooting_speed = 0.15
var shooting_speed = 0.5
var shooting_damage = 5.0

func _physics_process(delta: float) -> void:
	rotateWeapon()
	
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
		

func rotateWeapon():
	if %ShootingPoint.global_position.x < player.global_position.x:
		scale = Vector2(1, -1)
		return
		
	if  %ShootingPoint.global_position.x < player.global_position.x + 50:
		return 
		
	scale = Vector2(1, 1)

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	new_bullet.bullet_damage = shooting_damage
	%ShootingPoint.add_child(new_bullet)
	shoot_sound()
	
func shoot_sound():
	var random_number = randf() * 0.3
	var random_pitch = 0.9 + random_number - 0.15
	%ShootSound.pitch_scale = random_pitch
	%ShootSound.play()

func upgrade_weapon_speed():
	var new_shooting_speed = shooting_speed - shooting_speed * 0.15
	if shooting_speed > maximum_shooting_speed:
		var utils = Utils.new()
		var rounded_shooting_speed = utils.round_to_dec(new_shooting_speed, 2)
		shooting_speed = rounded_shooting_speed
		%ShootingTimer.wait_time = rounded_shooting_speed

func upgrade_weapon_damage():
	shooting_damage += round(shooting_damage * 0.2)

func _on_timer_timeout() -> void:
	shoot()

func _on_player_weapon_upgrade(upgrade_type) -> void:
	if upgrade_type == "speed":
		upgrade_weapon_speed()
	if upgrade_type == "damage":
		upgrade_weapon_damage()
