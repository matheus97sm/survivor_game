extends Button

@onready var custom_icon = preload("res://pistol/impact/circle.png")


func _ready() -> void:
	instantiate_button()

func instantiate_button():
	var new_icon = Sprite2D.new()
	new_icon.texture = custom_icon
	new_icon.
	%LevelUpIcon.add_child(new_icon)
	%LevelUpTitle.text = "ablue ablue +1"
	%LevelUpDescription.text = "text ablue ablue +2312"
