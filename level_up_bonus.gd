extends CanvasLayer

@onready var gun = preload("res://gun.tscn")
@onready var player = get_node("/root/Game/Player")


func _on_new_weapon_bonus_button_down() -> void:
	var new_gun = gun.instantiate()
	player.add_child(new_gun)
	visible = false
	get_tree().paused = false
