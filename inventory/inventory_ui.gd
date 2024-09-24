extends CanvasLayer


@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")

var is_open = false


func _ready() -> void:
	inventory.update.connect(update_slots)
	update_slots()
	close()


func update_slots():
	var slots = %SlotsContainer.get_children()
	for item in range(min(inventory.slots.size(), slots.size())):
		slots[item].update(inventory.slots[item])


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			open()


func open():
	visible = true
	is_open = true
	get_tree().paused = true


func close():
	visible = false
	is_open = false
	get_tree().paused = false
