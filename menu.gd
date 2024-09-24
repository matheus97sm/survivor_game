extends CanvasLayer


func _on_return_to_main_menu_button_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_resume_game_button_button_up() -> void:
	get_tree().paused = false
	visible = false
